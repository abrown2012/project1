class Project1::CLI

    def call 
        puts "Welcome!"
        list_categories
        menu_categories
        
    end 

    def menu_categories
        input = nil 
        while input != "exit"
            puts 'Please enter the number corresponding to the category of your interest, type "categories" to see the categories again, or type "exit" to close the program:'
            input = gets.strip.downcase
            if input.to_i > 0 && input.to_i <= @categories.count
                the_category = @categories[input.to_i-1]
                puts "Here are the mutual funds in the #{the_category.name} category:"
                print_selected(the_category.name)
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
        @categories = Project1::Scraper.new.print_categories
        @categories.each.with_index(1) do |category, i|
            puts "#{i}. #{category.name}"
        end 
    end 

    def print_selected(selected_category)
        
        @funds = Project1::Scraper.new.print_funds
        @funds.each do |fund|
            if fund.category == selected_category
                puts "#{fund.name} - #{fund.symbol} 1-YR return: #{fund.one_yr_return}% 2-YR return: #{fund.two_yr_return}% 3-YR return: #{fund.three_yr_return}%."
            end 
        end 
    end 

    def goodbye
        puts "Thank for using our scraper! See you again soon!"
    end 
end
