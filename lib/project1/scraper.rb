class Project1::Scraper
    attr_accessor :name

    def get_page 
        Nokogiri::HTML(open("https://www.kiplinger.com/kiplinger-tools/investing/t041-s001-top-performing-mutual-funds/index.php"))
    end 

    def get_categories
        get_page.css("form#form1").text.strip!.split(/\n/).drop(1).flatten
    end 

    def get_url_value
        values = get_page.css("select#URL option").drop(1)
        values.map do |value|
            new_value = value['value'].to_str.sub('/kiplinger-tools/investing/t041-s001-top-performing-mutual-funds/index.php?table_select=', '')
        end 
    end 

    def unique_urls 
        get_url_value.uniq
    end 

    def get_funds
        all_funds = []
        self.unique_urls.each do |unique_url| 
            doc = Nokogiri::HTML(open("https://www.kiplinger.com/kiplinger-tools/investing/t041-s001-top-performing-mutual-funds/index.php?table_select=#{unique_url}"))
            all_funds << doc.css("td.col")
        end 
        all_funds
    end 

    def get_funds_by_category(url)
        all_funds = []
        doc = Nokogiri::HTML(open("https://www.kiplinger.com/kiplinger-tools/investing/t041-s001-top-performing-mutual-funds/index.php?table_select=#{url}"))
        all_funds << doc.css("td.col")
        all_funds
    end 


    def make_funds
        j = 0 
        self.get_funds.each do |fund_data|
            i = 0 
            while i < 500
                if Project1::Fund.all.find {|fund| fund.name == fund_data[i].text}
                i += 10 
                else 
                    fund = Project1::Fund.new 
                    fund.name = fund_data[i].text
                    fund.symbol = fund_data[i+1].text
                    fund.one_yr_return = fund_data[i+2].text.tr('%', '')
                    fund.three_yr_return = fund_data[i+3].text.tr('%', '')
                    fund.five_yr_return = fund_data[i+4].text.tr('%', '')
                    fund.ten_yr_return = fund_data[i+5].text.tr('%', '')
                    fund.twenty_yr_return = fund_data[i+6].text.tr('%', '')
                    fund.category = get_categories[j].strip![15..-1]
                    i += 10 
                end
            end 
            j +=1
        end 
    end

    def make_categories 
        self.get_categories.each_with_index do |category_name, i|
            category = Project1::Category.new 
            category.name = category_name.strip![15..-1]
            category.url_value = get_url_value[i]
        end 
    end 

    def print_funds(url)
        self.make_funds(url)
        Project1::Fund.all.each.with_index(1) do |fund, i |
            if fund.name && fund.name != ""
            end 
        end
    end 

    def print_categories
        self.make_categories 
        Project1::Category.all.each.with_index(1) do |category, i| 
            if category.name && category.name != ""
            end
        end
    end 

end
