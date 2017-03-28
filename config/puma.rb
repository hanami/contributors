workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['HANAMI_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

port        ENV['PORT']     || 2300
environment ENV['RACK_ENV'] || 'development'
