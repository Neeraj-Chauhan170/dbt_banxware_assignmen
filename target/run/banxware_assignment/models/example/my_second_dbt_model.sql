
  create or replace   view HOME_ASSIGNMENT.PUBLIC.my_second_dbt_model
  
   as (
    -- Use the `ref` function to select from other models

select *
from HOME_ASSIGNMENT.PUBLIC.my_first_dbt_model
where id = 1
  );

