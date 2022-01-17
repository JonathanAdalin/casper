require 'colorize'
require 'ruby-progressbar'

NUM_QUESTIONS_TOTAL = 12
NUM_QUESTIONS_PER_PERIOD = 6

# Fake variables for testing # TODO Remove
WELCOME_TIME_S = 4
SCENARIO_TIME_S = 4
QUESTION_TIME_S = 10
BREAK_TIME_S = 10

# Real variables TODO Enable
WELCOME_TIME_S = 30
# SCENARIO_TIME_S = 60
# QUESTION_TIME_S = 5 * 60
# BREAK_TIME_S = 10 * 60

PROGRESS_BAR_MAX_ITERATIONS = 80

def display_welcome
    system "clear"
    puts "Welcome to the Casper simulation.".colorize(:yellow)
    puts "There will be #{NUM_QUESTIONS_TOTAL} total questions.".colorize(:cyan)
    puts "There will be a break after #{NUM_QUESTIONS_PER_PERIOD} questions."
        .colorize(:cyan)
    puts "\n"
    display_progress_bar(5)
end

def display_scenario(index)
    system "clear"
    puts "This is the scenario #{index.to_s}"
    display_progress_bar(SCENARIO_TIME_S)
end

def display_questions(index)
    system "clear"
    puts "These are the questions for scenario #{index.to_s}"
    display_progress_bar(QUESTION_TIME_S)
end

def display_break
    system "clear"
    puts "This is a break"
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
        display_scenario(scenario_index)
        display_questions(scenario_index)
        scenario_index += 1
    end
    display_break
end
