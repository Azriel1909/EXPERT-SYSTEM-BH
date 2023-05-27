% Knowledge Base
% Define symptoms and their corresponding mental health disorders

% Depression Symptoms
symptom(fatigue).
symptom(loss_of_interest).
symptom(difficulty_sleeping).
symptom(feelings_of_worthlessness).
symptom(concentration_difficulties).
symptom(persistent_sadness).
symptom(feelings_of_guilt).
symptom(suicidal_thoughts).

% Depression Anxiety
symptom(restlessness).
symptom(irritability).
symptom(feeling_nervous).
symptom(trembling).
symptom(feeling_weak).
symptom(gastrointestinal_problems).
symptom(hyperventilation).

% Depression Bipolar
symptom(elevated_mood).
symptom(decreased_need_for_sleep).
symptom(racing_thoughts).
symptom(distractibility).
symptom(poor_decision_making).
symptom(unusual_talkativeness).

disorder(depression).
disorder(anxiety).
disorder(bipolar).
% Add more disorders 

% Rules for diagnosis
% Add more rules 

diagnose_patient(Symptoms, depression) :-
    member(fatigue, Symptoms),
    member(loss_of_interest, Symptoms),
    member(difficulty_sleeping, Symptoms),
    member(feelings_of_worthlessness, Symptoms),
    member(concentration_difficulties, Symptoms),
    member(persistent_sadness, Symptoms),
    member(feelings_of_guilt, Symptoms),
    member(suicidal_thoughts, Symptoms).

diagnose_patient(Symptoms, anxiety) :-
    member(fatigue, Symptoms),
    member(restlessness, Symptoms),
    member(irritability, Symptoms),
    member(feeling_nervous, Symptoms),
    member(trembling, Symptoms),
    member(feeling_weak, Symptoms),
    member(gastrointestinal_problems, Symptoms),
    member(hyperventilation, Symptoms).

diagnose_patient(Symptoms, bipolar) :-
    member(elevated_mood, Symptoms),
    member(decreased_need_for_sleep, Symptoms),
    member(racing_thoughts, Symptoms),
    member(distractibility, Symptoms),
    member(poor_decision_making, Symptoms),
    member(unusual_talkativeness, Symptoms),

% User Interface
% Define predicates for interacting with the user

ask_symptom(Symptom) :-
    format('Do you have ~w? (yes/no) ', [Symptom]),
    read(Response),
    Response = yes.

gather_symptoms(Symptoms) :-
    findall(Symptom, symptom(Symptom), AllSymptoms),
    gather_symptoms_helper(AllSymptoms, Symptoms).

gather_symptoms_helper([], []).
gather_symptoms_helper([Symptom | Rest], [Symptom | Symptoms]) :-
    ask_symptom(Symptom),
    gather_symptoms_helper(Rest, Symptoms).
gather_symptoms_helper([_ | Rest], Symptoms) :-
    gather_symptoms_helper(Rest, Symptoms).

% Main Predicate
% Entry point to the expert system

mental_health_diagnosis :-
    format('--- Mental Health Expert System ---~n'),
    format('--- By Ximena Toledo Rivera ---~n'),
    format('Please answer the following questions:~n'),
    gather_symptoms(Symptoms),
    diagnose_patient(Symptoms, Disorder),
    format('Based on the symptoms provided, the possible diagnosis is: ~w~n', [Disorder]).


% Sample Usage
% Query mental_health_diagnosis to start the expert system
% ?- mental_health_diagnosis.