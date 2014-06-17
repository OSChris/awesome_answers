namespace :question_generator do

  desc "Generate ten questions with 5 answers each."
  task :generate_ten => :environment do 
    10.times do 
      question = Question.create(title: Faker::Company.bs, 
                                 description: Faker::Lorem.sentence)

      5.times do 
        question.answers.create(body: Faker::Company.bs)
      end

    end
    
  end

end
