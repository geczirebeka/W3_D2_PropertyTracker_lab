require('pry')
require_relative('models/PropertyTracker')

PropertyTracker.delete_all()

property1 = PropertyTracker.new({'address' => '123 sesame street', 'value' => 1000000, 'number_of_bedrooms' => 10, 'build' => 'house'})
property1.save()
property2 = PropertyTracker.new({'address' => '10 dundas street', 'value' => 300000, 'number_of_bedrooms' => 5, 'build' => 'house'})
property2.save()
property1.value = 3000000
property1.update
# property2.delete()
find = PropertyTracker.find_by_id(property2.id)
find_address = PropertyTracker.find_by_address(property2.address)

binding.pry
nil