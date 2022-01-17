require 'ruby-progressbar'

NUM_QUESTIONS_TOTAL = 12
NUM_QUESTIONS_PER_PERIOD = 6

# Fake variables for testing
SCENARIO_TIME_S = 3
QUESTION_TIME_S = 15
BREAK_TIME_S = 3

# Real time
# SCENARIO_TIME_S = 60
# QUESTION_TIME_S = 5 * 60
# BREAK_TIME_S = 10 * 60

PROGRESS_BAR_MAX_ITERATIONS = 80

def display_scenario(index)
    puts "This is the scenario #{index.to_s}"
    display_progress_bar(SCENARIO_TIME_S)
end

def display_questions
    puts "These are the questions"
    display_progress_bar(QUESTION_TIME_S)
end

def display_break
    puts "This is a break"
    display_progress_bar(BREAK_TIME_S)
end

def display_progress_bar(total_time_s)
    progressbar_max_iterations = 80;
    progressbar = ProgressBar.create(
        :total => progressbar_max_iterations,
        :title => "Time Left", 
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

global_scenario_index = 1
while global_scenario_index <= NUM_QUESTIONS_TOTAL do
    (1..NUM_QUESTIONS_PER_PERIOD).each do |_|
        display_scenario(global_scenario_index)
        display_questions
        global_scenario_index += 1
    end
    display_break
end
