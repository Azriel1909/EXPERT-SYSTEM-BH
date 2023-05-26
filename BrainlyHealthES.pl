% Knowledge Base
% Define symptoms and their corresponding mental health disorders

symptom(fatigue).
symptom(loss_of_interest).
symptom(difficulty_sleeping).
symptom(restlessness).
symptom(elevated_mood).
symptom(decreased_need_for_sleep).

disorder(depression, [fatigue, loss_of_interest, difficulty_sleeping]).
disorder(anxiety, [fatigue, restlessness]).
disorder(bipolar, [elevated_mood, decreased_need_for_sleep]).

% Rules for diagnosis

diagnose_patient(Symptoms, Disorder) :-
    disorder(Disorder, DisorderSymptoms),
    subset(DisorderSymptoms, Symptoms).

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
    format('Please answer the following questions:~n'),
    gather_symptoms(Symptoms),
    diagnose_patient(Symptoms, Disorder),
    format('Based on the symptoms provided, the possible diagnosis is: ~w~n', [Disorder]).

% Sample Usage
% Query mental_health_diagnosis to start the expert system

?- mental_health_diagnosis.
