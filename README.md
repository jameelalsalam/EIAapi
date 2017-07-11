# EIAapi
A wrapper for the Energy Information Administration (EIA) API in R

The author of this package is not affiliated with the EIA.

A free API key can be obtained here: https://www.eia.gov/opendata/

The EIA API includes several queyr endpoints:
 1) API Series query. For accessing data series by ID. Endpoint of form:
 
 http://api.eia.gov/series/?series_id=sssssss&api_key=YOUR_API_KEY_HERE[&num=][&out=xml|json]
 
 2) API Category query. EIA series are organized in categories and subcategories. The category query is useful for locating appropriate series IDs. Endpoint form:
 
  http://api.eia.gov/category/?api_key=YOUR_API_KEY_HERE[&category_id=nn][&out=xml|json]
  
 3) Also: API Relation query and Geoset query, which are not yet within scope of this package
