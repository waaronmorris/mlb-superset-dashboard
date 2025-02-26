{{ config(
        materialized='table'
        )
}}

Select
    bx.*
  , date_diff('day', first_value(bx.game_date) OVER  (PARTITION BY bx.season ORDER BY bx.game_date), bx.game_date) + 1 as days_in_season
  , sched.* exclude (game_pk, season)
    FROM
        {{ source("mlb_stats","box_scores") }}   bx
            LEFT JOIN
            {{ source("mlb_stats","schedule") }} sched
                ON bx.game_pk = sched.game_pk
