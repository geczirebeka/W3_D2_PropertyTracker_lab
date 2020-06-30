require('pg')

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

    def save()
        db = PG.connect ({dbname: 'property_tracker', host: 'localhost' })
        sql = "INSERT INTO property_tracker (address, value, number_of_bedrooms, build) VALUES ($1, $2, $3, $4) RETURNING id"
        values =[@address, @value, @number_of_bedrooms, @build]
        db.prepare("save", sql)
        @id = db.exec_prepared("save", values)[0]["id"].to_i()
        db.close()
    end

    def update()
        db = PG.connect ({dbname: 'property_tracker', host: 'localhost' })
        sql = "UPDATE property_tracker SET (address, value, number_of_bedrooms, build) = ($1, $2, $3, $4) WHERE id = $5"
        values = [@address, @value, @number_of_bedrooms, @build, @id]
        db.prepare('update', sql)
        db.exec_prepared('update', values)
        db.close()
    end

    def delete()
        db = PG.connect ({dbname: 'property_tracker', host: 'localhost' })
        sql = "DELETE FROM property_tracker WHERE id = $1"
        value = [@id]
        db.prepare("delete", sql)
        db.exec_prepared("delete", value)
        db.close()
    end

    def self.delete_all()
        db = PG.connect ({dbname: 'property_tracker', host: 'localhost' })
        sql = "DELETE FROM property_tracker"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close()
    end

    def self.find_by_id(id)
        db = PG.connect ({dbname: 'property_tracker', host: 'localhost' })
        sql = "SELECT * FROM property_tracker WHERE id = $1"
        value = [id]
        db.prepare("find_by_id", sql)
        result = db.exec_prepared("find_by_id", value)[0]
        db.close()
        return self.new(result)
    end

end