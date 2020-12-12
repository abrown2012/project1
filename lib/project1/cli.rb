class Project1::CLI

    def call 
        Project1::Scraper.new.make_categories
        Project1::Scraper.new.make_funds
        puts ""
        puts "Welcome!"
        list_categories
        menu_categories
        
    end 

    def menu_categories
        input = nil 
        while input != "exit"
            puts 'Please enter the number corresponding to the category of your interest, type "categories" to see the categories again, or type "exit" to close the program:'
            input = gets.strip.downcase
            @categories = Project1::Category.all
            if input.to_i > 0 && input.to_i <= @categories.count
                the_category = @categories[input.to_i-1]
                puts "Here are the mutual funds in the #{the_category.name} category:"
                print_selected(the_category)
            elsif input == "categories"
                list_categories 
            elsif input == "exit"
                goodbye
            else 
                puts "Sorry, I did not understand that answer."
            end
        end
    end 
    
    def list_categories 
        puts "Here are the categories of our mutual funds:"
        categories_table = TTY::Table.new(header: ["Id", "Category"])
        Project1::Category.all.each.with_index(1) do |category, i|
            categories_table << ["#{i}".blue,  "#{category.name}"]
        end 
        puts categories_table.render(:unicode)
    end 

    def print_selected(selected_category)
        funds_table = TTY::Table.new(header: ["Name", "Symbol", "1-Yr Return", "3-Yr Return", "5-Yr Return", "10-Yr Return", "20-Yr Return"])
        @funds = Project1::Fund.all
        @funds.each do |fund|
            if fund.category == selected_category.name
                funds_table << ["#{fund.name}".blue, "#{fund.symbol}".red, "#{fund.one_yr_return}%".green, "#{fund.three_yr_return}%".green, "#{fund.five_yr_return}%".green, "#{fund.ten_yr_return}%".green, "#{fund.twenty_yr_return}%".green]
            end 
        end 
        puts funds_table.render(:unicode)
    end 

    def goodbye
        puts "Thank for using our scraper! See you again soon!"
    end 
end
