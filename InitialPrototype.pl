% Knowledge Base
% Define symptoms and their corresponding mental health disorders

symptom(fatigue).
symptom(loss_of_interest).
symptom(difficulty_sleeping).
symptom(restlessness).
symptom(elevated_mood).
symptom(decreased_need_for_sleep).
symptom(feelings_of_worthlessness).
symptom(concentration_difficulties).
symptom(irritability).
symptom(racing_thoughts).
% Add more symptoms 

disorder(depression, [fatigue, loss_of_interest, difficulty_sleeping, feelings_of_worthlessness, concentration_difficulties]).
disorder(anxiety, [fatigue, restlessness, irritability, concentration_difficulties]).
disorder(bipolar, [elevated_mood, decreased_need_for_sleep, racing_thoughts]).
% Add more disorders as needed

% Rules for diagnosis
% Add more rules as needed

diagnose_patient(Symptoms, depression) :-
    subset([fatigue, loss_of_interest, difficulty_sleeping], Symptoms).

diagnose_patient(Symptoms, anxiety) :-
    subset([fatigue, restlessness, irritability], Symptoms).

diagnose_patient(Symptoms, bipolar) :-
    subset([elevated_mood, decreased_need_for_sleep, racing_thoughts], Symptoms).

% User Interface
% Define predicates for interacting with the user
% Add more predicates as needed

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
    format('Please answer the following questions:~n'),
    gather_symptoms(Symptoms),
    diagnose_patient(Symptoms, Disorder),
    format('Based on the symptoms provided, the possible diagnosis is: ~w~n', [Disorder]).

% Sample Usage
% Query mental_health_diagnosis to start the expert system

?- mental_health_diagnosis.