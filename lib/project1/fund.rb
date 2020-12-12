class Project1::Fund 

    attr_accessor :name, :category, :symbol, :one_yr_return, :three_yr_return, :five_yr_return

    @@all = []

    def initialize
        @@all << self 
    end 

    def self.all
        @@all 
    end 

end
