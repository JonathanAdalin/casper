NUM_QUESTIONS_TOTAL = 12
NUM_QUESTIONS_PER_PERIOD = 6

# Fake variables for testing
SCENARIO_TIME_S = 1
QUESTION_TIME_S = 1
BREAK_TIME_S = 1

# Real time
# SCENARIO_TIME_S = 60
# QUESTION_TIME_S = 5 * 60
# BREAK_TIME_S = 10 * 60

def display_scenario(index)
    puts "This is the scenario #{index.to_s}"
end

def display_questions
    puts "These are the questions"
end

def display_break
    puts "This is a break"
end

global_scenario_index = 1
start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

while global_scenario_index <= NUM_QUESTIONS_TOTAL do
    (1..NUM_QUESTIONS_PER_PERIOD).each do |_|
        display_scenario(global_scenario_index)
        display_questions
        global_scenario_index += 1
    end
    display_break
end
