class Project1::Category 

    attr_accessor :name

    def self.today
        # scrape troweprice and return funds based on that data 
        self.scrape_categories
    end 

    def self.scrape_categories
        categories = []

        categories << self.scrape_klippinger
        #go to TRowePrice, find the mutual funds 
        #extract the properties
        #instantiate a fund
        categories
    end 

    def self.scrape_klippinger
        doc = Nokogiri::HTML(open("https://www.kiplinger.com/kiplinger-tools/investing/t041-s001-top-performing-mutual-funds/index.php"))
        
        categories = doc.css("form#form1").text.strip!.split(/\n/).drop(1)
        categories.each do |category_title|
            category = self.new 
            category.name = category_title.strip! 
        end 
        
        
    end 

end