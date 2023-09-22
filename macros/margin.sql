{% macro margin(turnover, purchase_cost, precision=2) %}
   ROUND( ({{ turnover }} - {{ purchase_cost }}) )
{% endmacro %}