json.id @employee.id
json.name @employee.name
json.salary @employee.salary
json.rating @employee.rating
json.type @employee.type
json.resigned @employee.resigned if @employee.resigned
if @employee.type != 'ChiefExecutiveOfficer'
  json.reporter_id @employee.reporter_id
  json.reporter_name @employee.reporter.name
end
