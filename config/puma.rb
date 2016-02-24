bind "tcp://0.0.0.0:3000"

tag "Data server"

threads 0, 16

pidfile "./tmp/puma.pid"
state_path "./tmp/puma.state"
