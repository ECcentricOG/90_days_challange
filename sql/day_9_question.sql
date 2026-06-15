-- You have a 5TB fact table partitioned by day. A query scanning 3 years of data is extremely slow. 
-- How do you redesign the partitioning strategy? What is the max partition count target? 
-- How does partition pruning work and what can break it?

Daily partitioning causes a 3-year query to scan around 1,100 partitions.
I would redesign it using monthly range partitions or range + hash subpartitioning.
My target would be hundreds of partitions, ideally under 1,000 active partitions.
Partition pruning works by scanning only the partitions that match the query predicate.
Pruning can be broken by functions, expressions, implicit conversions, and non-sargable predicates on the partition key.
