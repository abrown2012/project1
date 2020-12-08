class Project1::Category 

    attr_accessor :name, :url_value

    @@all = []

    def initialize
        @@all << self 
    end 

    def self.all
        @@all 
    end 
       
end