# mini-profilerの結果をデフォルトoffへ
if defined?(Rack::MiniProfiler)
  Rack::MiniProfiler.config.auto_inject = false
end
