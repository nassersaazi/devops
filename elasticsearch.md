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

GET logstash-2021.11.19-000001/_mapping

PUT logstash-2021.11.19-000002
{
  "mappings": {
    "properties": {
      "location": {
        "type": "geo_point"
      }
    }
  }
}

POST _reindex
{
  "source": {
    "index": "logstash-2021.11.19-000001"
  },
  "dest": {
    "index": "logstash-2021.11.19-000002"
  }
}

// creating a template
PUT _template/geo-mapping
{
  "order": 1,
  "version": 10,
  "index_patterns": [
    "logstash-*"
  ],
  "mappings": {
      "properties": {
        "geoip": {
          "dynamic": true,
          "properties": {
            "ip": {
              "type": "ip"
            },
            "location": {
              "type": "geo_point"
            },
            "latitude": {
              "type": "half_float"
            },
            "longitude": {
              "type": "half_float"
            }
          }
        }
      }
    
  }
}

docker exec -it logstash /bin/bash -c "bin/logstash-plugin install logstash-filter-elapsed"


### Resources

[A few good ways to use Elasticsearch devtools for search](https://www.youtube.com/watch?v=CCTgroOcyfM)<br>

[A few good ways to use Elasticsearch devtools for search part 3](https://www.youtube.com/watch?v=2KgJ6TQPIIA)<br>

### Commands

curl -XPOST 'http://localhost:9200/_cache/clear' --> clear elasticsearch cache
