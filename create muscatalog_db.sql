CREATE SCHEMA public AUTHORIZATION pg_database_owner;

CREATE TABLE public.artist (
	id SERIAL NOT NULL,
	CONSTRAINT artist_id_pk PRIMARY KEY (id),
	"name" varchar(64) UNIQUE NOT NULL);

CREATE TABLE public.collection (
	id SERIAL NOT NULL,
	CONSTRAINT collection_id PRIMARY KEY (id),
	"year of issue" integer CHECK ("year of issue" > 1900) NOT NULL,
	"name" varchar(128) UNIQUE NOT NULL);

CREATE TABLE public.genre (
	id SERIAL NOT NULL,
	CONSTRAINT genre_id_pk PRIMARY KEY (id),
	"name" varchar(64) UNIQUE NOT NULL);

CREATE TABLE public.album (
	id SERIAL NOT NULL,
	CONSTRAINT album_id_pk PRIMARY KEY (id),
	"name" varchar(128) NOT NULL,
	"release year" integer CHECK ("release year" > 1900) NOT NULL);

CREATE TABLE public.artist_album (
	id SERIAL NOT NULL,
	CONSTRAINT artist_album_pk PRIMARY KEY (id),
	artist_id integer NOT NULL,
	CONSTRAINT artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artist(id),
	album_id integer NOT NULL,
	CONSTRAINT album_id_fkey FOREIGN KEY (album_id) REFERENCES public.album(id));

CREATE TABLE public.artist_genre (
	id SERIAL NOT NULL,
	CONSTRAINT artist_genre_pk PRIMARY KEY (id),
	artist_id integer NOT NULL,
	CONSTRAINT artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artist(id),
	genre_id integer NOT NULL,
	CONSTRAINT genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genre(id));

CREATE TABLE public.song (
	id SERIAL NOT NULL,
	CONSTRAINT song_pk PRIMARY KEY (id),
	"name" varchar(128) NOT NULL,
	album integer NOT NULL,
	CONSTRAINT song_fk FOREIGN KEY (id) REFERENCES public.album(id),
	duration integer CHECK (duration > 0 AND duration < 86400) NOT NULL);

CREATE TABLE public.song_collection (
	id SERIAL NOT NULL,
	CONSTRAINT song_collection_pk PRIMARY KEY (id),
	song_id integer NOT NULL,
	CONSTRAINT song_id_fkey FOREIGN KEY (song_id) REFERENCES public.song(id),
	collection_id integer NOT NULL,
	CONSTRAINT collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collection(id));
