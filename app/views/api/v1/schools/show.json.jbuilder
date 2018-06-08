json.school do
  json.id @school.id
  json.name @school.name
  json.address @school.address
  json.zip_code @school.zip_code
  json.city @school.city
  json.opening_hours @school.opening_hours
  json.phone @school.phone
  json.email @school.email
  json.latitude @school.latitude
  json.longitude @school.longitude
  json.students_count @school.students_count
  json.status @school.status
end