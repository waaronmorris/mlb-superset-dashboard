{{ config(
        materialized='table'
        )
}}

Select
    *
  , (
        IFNULL(ab_points, 0)
            + IFNULL(h_points, 0)
            + IFNULL(doubles_points, 0)
            + IFNULL(triples_points, 0)
            + IFNULL(home_runs_points, 0)
            + IFNULL(walks_points, 0)
            + IFNULL(hits_by_pitch, 0)
            + IFNULL(stolen_bases, 0)
            + IFNULL(caught_stealing, 0)
            + IFNULL(innings_pitched, 0)
            + IFNULL(strikeouts_points, 0)
            + IFNULL(walks_pitched_points, 0)
            + IFNULL(hit_batsmen_points, 0)
            + IFNULL(home_runs_allowed_points, 0)
            + IFNULL(saves_points, 0)
            + IFNULL(holds_points, 0)
        )
        as total_points
FROM
    {{ source("mlb_stats","fantasy_box_scores") }}