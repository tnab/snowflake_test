connection: "snowflake_looker"

# include all the views
include: "*.view"
include: "//weather_data/*.view"

datagroup: snowflake_sandbox_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: snowflake_sandbox_default_datagroup

explore: all_types {}

# explore: order_items {
#   fields: [ALL_FIELDS*, -users.dynamic_age_tier]
#   join: orders {
#     type: left_outer
#     sql_on: ${order_items.order_id} = ${orders.id} ;;
#     relationship: many_to_one
#   }
#   join: users {
#     type: left_outer
#     sql_on: ${orders.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: bucket_size {
    sql_on: ${bucket_size.id} = ${users.id} ;;
    relationship: one_to_one
  }
}

explore: users {
  join: bucket_size {
    sql_on: ${bucket_size.id} = ${users.id} ;;
    relationship: one_to_one
  }
}

explore: bucket_size {}
