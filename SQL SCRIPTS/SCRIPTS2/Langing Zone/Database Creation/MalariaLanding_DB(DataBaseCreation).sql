--Creation of Landing_DB for Malaria_Raw Files 
IF DB_ID('MalariaLanding_DB') IS NULL
BEGIN
     CREATE DATABASE MalariaLanding_DB;
END