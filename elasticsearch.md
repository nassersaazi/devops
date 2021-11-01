### Some search commands

GET _cluster/health

GET _nodes/stats

GET syslog-received-on-tcp/_search
{
  "track_total_hits": true
}

GET syslog-received-on-tcp/_search
{
  "query": {
    "range": {
      "received_at": {
        "gte": "2021-09-20",
        "lte": "2021-10-21"
      }
    }
  }
}

GET syslog-received-on-tcp/_search
{
  "aggs": {
    "by_program_name": {
      "terms": {
        "field": "syslog_program",
        "size": 10
      }
    }
  }
}

GET syslog-received-on-tcp/_search
{
  "query": {
    "match": {
      "message": {
        "query": "Shared secret is incorrect"
      }
    }
    
  }
}

### Resources

[A few good ways to use Elasticsearch devtools for search](https://www.youtube.com/watch?v=CCTgroOcyfM)<br>

[A few good ways to use Elasticsearch devtools for search part 3](https://www.youtube.com/watch?v=2KgJ6TQPIIA)<br>