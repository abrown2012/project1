class Project1::CLI

    def call 
        puts "Welcome!"
        list_categories
        menu_categories
        goodbye
    end 

    def menu_categories
        input = nil 
        while input != "exit"
            puts 'Please enter the number corresponding to the category of your interest, type "categories" to see the categories again, or type "exit" to close the program:'
            input = gets.strip.downcase
            if input.to_i > 0 
                the_category = @categories[input.to_i-1]
                puts "Here are the mutual funds in the #{the_category.name} category:"
            elsif input == "categories"
                list_categories 
            else 
                puts 'I did not get that. enter the number corresponding to the category of your interest, type "categories" to see the categories again, or type "exit" to close the program:'
            end
        end
    end 
    
    def list_categories 
        puts "Here are the categories of our mutual funds:"
      
        @categories = Project1::Category.today.flatten
        @categories.each.with_index(1) do |category, i|
            puts "#{i}. #{category}"
        end 
    end 

    def list_funds 
        puts "Here are our mutual funds:"
      
        @funds = Project1::Fund.today
        @funds.each.with_index(1) do |fund, i|
            puts "#{1}. #{fund}"
        end 
    end 

    def menu
        input = nil 
        while input != "exit"
        puts "Enter the number corresponding to the selected mutual fund, type list to see the funds again, or type exit to close the program:"
        input = gets.strip.downcase
            if input.to_i > 0 
                the_fund = @funds[input.to_i-1]
                puts "#{the_fund.name} - #{the_fund.price}"
            elsif input == "list"
                list_funds 
            else 
                puts 'Sorry, I did not get that. Enter the number corresponding to the selected mutual fund, type list to see the funds again, or type exit to close the program:'
            end
        end
    end 

    def goodbye
        puts "Thank for using our scraper! See you again soon!"
    end 
end
