view: users {
  sql_table_name: LOOKER_TEST.USERS ;;



# Dynamic Buckets

  parameter: bucket_count {
    type: number
  }

  dimension: dynamic_age_tier {
    type: number
    sql: TRUNCATE(${TABLE}.age / upper(${bucket_size.range}/{% parameter bucket_count %}), 0)
      * TRUNCATE(${bucket_size.range}/{% parameter bucket_count %},0) ;;
  }

#   dimension: dynamic_age_tier_mod {
#     type: number
#     sql: truncate (${TABLE}.age / round(${bucket_size.range}/{% parameter bucket_count %}),0)
#       * {% parameter bucket_count %} ;;
#   }

#   dimension: 2_dynamic_age_tier {
#     type: number
#     sql: truncate (${TABLE}.age / round(${bucket_size.range}/{% parameter bucket_count %}),0)
#       * {% parameter bucket_count %} ;;
#   }

  # End of dynamic buckets


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}."AGE" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: epoch_at {
    type: number
    sql: ${TABLE}."EPOCH_AT" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: yyyymmdd_at {
    type: number
    sql: ${TABLE}."YYYYMMDD_AT" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, orders.count]
  }
}
