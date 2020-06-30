

class PropertyTracker

    attr_accessor :address, :value, :number_of_bedrooms, :build
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @address = options['address']
        @value = options['value'].to_i()
        @number_of_bedrooms = options['number_of_bedrooms'].to_i()
        @build = options['build']

    end

end