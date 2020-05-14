drop table if exists states;
create table states (
	state_name varchar (25),
	state_abbreviation char (2),
	population int,
	state_property_tax_rate float
	
);

insert into states (state_name, state_abbreviation, population, state_property_tax_rate)
values 
('Florida', 'FL', 21477737, 0.0093),
('Alabama', 'AL', 4903185, 0.0042),
('Texas', 'TX', 28995881, 0.0181),
('Kentucky', 'KY', 4467673, 0.0086),
('Virginia', 'VA', 8535519, 0.0081),
('Louisiana', 'LA', 4648794, 0.0053),
('Utah', 'UT', 3205958, 0.0064),
('Vermont', 'VT', 623989, 0.0188);

select * from states;

select * state_abbreviation from states order by state_abbreviation;

select * from states where population > 5000000 and state_property_tax_rate  < .01;

