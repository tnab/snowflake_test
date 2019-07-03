view: users {
  sql_table_name: LOOKER_TEST.USERS ;;



# Dynamic Buckets

  parameter: bucket_count {
    type: number
  }

  dimension: tier_size {
    type: number
    sql: ${bucket_size.range}/{% parameter bucket_count %} ;;

  }

  dimension: customer_segments {
    case: {
      when: {
        sql: ${name} LIKE '%ar%'
          and MOD(${id},2)  = 0 ;;
        label: "tampons first order"
      }
      else: "Period a la carte"
    }
  }

  dimension: dynamic_bucket  {
    sql:
        concat(${age} - mod(${age},${tier_size}),
          concat('-', ${age} - mod(${age},${tier_size}) + ${tier_size}))
      ;;
    order_by_field: dynamic_sort_field
  }

  dimension: dynamic_sort_field {
    sql:
      ${age} - mod(${age},${tier_size});;
    type: number

  }


#   dimension: dynamic_age_tier {
#     type: number
#     sql: TRUNCATE(${TABLE}.age / ${tier_size},0)
#       * ${tier_size} ;;
#   }

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

#   parameter: age_tier_bucket_size {
#     type: number
#   }
#
#   dimension: doc_dynamic_age_tier {
#     type: number
#     sql: TRUNCATE(${TABLE}.age / {% parameter age_tier_bucket_size %}, 0)
#       * {% parameter age_tier_bucket_size %} ;;
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

  #end_date liquid timeframe test

  filter: date_1 {
    type: date
  }

  filter: date_2 {
    type: date
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

  measure: count_2 {
    type: number
    sql: COALESCE(${count}*2,0)  ;;
  }
}
