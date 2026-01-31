# :cache_storeのみ
# Rails.application.config.session_store :cache_store

# namespaceを付与するため、cache引数をあらためて定義する
Rails.application.config.session_store :cache_store,
                                       cache: ActiveSupport::Cache::RedisCacheStore.new(
                                         redis: Redis::Cluster.new(nodes: %w[
                                           redis://redis-cluster-node-1:6379
                                           redis://redis-cluster-node-2:6379
                                           redis://redis-cluster-node-3:6379
                                         ]),
                                         namespace: "session_redis5"
                                       ),
                                       expire_after: 90.minutes,
                                       key: "_redis_cluster_example_session"