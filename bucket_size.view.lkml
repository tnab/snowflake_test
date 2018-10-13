view: bucket_size {
  derived_table: {
    sql:
    SELECT
    id AS id,
    age AS age,
    min(age) over() AS min,
    max(age) over() AS max
    FROM LOOKER_TEST.USERS
    ;;
  }

  dimension: id {}

  dimension: age {}

  dimension: min {}

  dimension: max {}

  dimension: range {
    sql: ${max} - ${min} ;;
  }
}
