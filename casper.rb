require 'colorize'
require 'ruby-progressbar'

NUM_QUESTIONS_TOTAL = 12
NUM_QUESTIONS_PER_PERIOD = 6
WELCOME_TIME_S = 15
SCENARIO_TIME_S = 60
QUESTION_TIME_S = 5 * 60
BREAK_TIME_S = 10 * 60

def display_welcome
    system "clear"
    puts "Welcome to the Casper simulation.".colorize(:yellow)
    puts "There will be #{NUM_QUESTIONS_TOTAL} total questions.".colorize(:cyan)
    puts "There will be a break after #{NUM_QUESTIONS_PER_PERIOD} questions."
        .colorize(:cyan)
    puts "\n"
    display_progress_bar(WELCOME_TIME_S)
end

def display_scenario(index)
    system "clear"
    puts "Scenario #{index.to_s}".colorize(:yellow)
    puts "\n"
    display_progress_bar(SCENARIO_TIME_S)
end

def display_questions(index)
    system "clear"
    puts "Scenario #{index.to_s} Questions".colorize(:yellow)
    puts "\n"
    display_progress_bar(QUESTION_TIME_S)
end

def display_break
    system "clear"
    puts "Break Time".colorize(:yellow)
    puts "\n"
    display_progress_bar(BREAK_TIME_S)
end

def display_progress_bar(total_time_s)
    progressbar_max_iterations = 80;
    progressbar = ProgressBar.create(
        :total => progressbar_max_iterations,
        :title => "Time Left On This Screen", 
        :progress_mark => " ", 
        :remainder_mark => "=")
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed_time_s = 0
    while elapsed_time_s < total_time_s do
        progressbar.increment
        sleep(total_time_s.to_f / progressbar_max_iterations)
        elapsed_time_s = 
            Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time
    end
    progressbar.finish
end

# Main

display_welcome
scenario_index = 1
while scenario_index <= NUM_QUESTIONS_TOTAL do
    (1..NUM_QUESTIONS_PER_PERIOD).each do |_|
        system('say ' + "Scenario #{scenario_index.to_s}")
        display_scenario(scenario_index)
        system('say ' + "Questions for scenario #{scenario_index.to_s}")
        display_questions(scenario_index)
        scenario_index += 1
    end
    break if scenario_index > NUM_QUESTIONS_TOTAL
    system('say "Time for a break"')
    display_break
end

system "clear"
puts "Well done! You have completed the Casper test simulation."
    .colorize(:yellow)
system('say "Well done"')
