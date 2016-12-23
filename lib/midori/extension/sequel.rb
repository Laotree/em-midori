safe_require 'sequel', 'gem install sequel'
require 'sequel/adapters/postgres'

class Sequel::Postgres::Adapter
  def execute_query(sql, args)
    @db.log_connection_yield(sql, self, args) do
      args ? await(defer{async_exec(sql, args)}) : await(defer{async_exec(sql)})
    end
  end
end
