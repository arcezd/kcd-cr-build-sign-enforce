output "redis_instance_id" {
  value = aws_elasticache_cluster.redis.id
}

output "cache_nodes" {
  value = aws_elasticache_cluster.redis.cache_nodes
}