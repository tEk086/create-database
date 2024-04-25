CREATE SCHEMA public AUTHORIZATION pg_database_owner;

CREATE TABLE public.artist (
	id int4 NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT artist_id_pk PRIMARY KEY (id),
	CONSTRAINT artist_name_un UNIQUE (name)
);

CREATE TABLE public.collection (
	id int4 NOT NULL,
	"year of issue" date NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT collection_id PRIMARY KEY (id)
);


CREATE TABLE public.genre (
	id int4 NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT genre_id_pk PRIMARY KEY (id)
);


CREATE TABLE public.album (
	id int4 NOT NULL,
	"name" varchar(100) NOT NULL,
	artist int4 NOT NULL,
	release_year date NOT NULL,
	CONSTRAINT album_id_pk PRIMARY KEY (id),
	CONSTRAINT album_artist_fk FOREIGN KEY (artist) REFERENCES public.artist(id)
);



CREATE TABLE public.artist_album (
	artist_id int4 NOT NULL,
	album_id int4 NOT NULL,
	id int4 NOT NULL,
	CONSTRAINT artist_album_pk PRIMARY KEY (id),
	CONSTRAINT album_id_fkey FOREIGN KEY (album_id) REFERENCES public.album(id),
	CONSTRAINT artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artist(id)
);


CREATE TABLE public.artist_genre (
	id int4 NOT NULL,
	artist_id int4 NOT NULL,
	genre_id int4 NOT NULL,
	CONSTRAINT artist_genre_pk PRIMARY KEY (id),
	CONSTRAINT artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artist(id),
	CONSTRAINT genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genre(id)
);


CREATE TABLE public.song (
	id int4 NOT NULL,
	"name" varchar NOT NULL,
	album int4 NOT NULL,
	duration interval minute to second NOT NULL,
	CONSTRAINT song_pk PRIMARY KEY (id),
	CONSTRAINT song_fk FOREIGN KEY (id) REFERENCES public.album(id)
);


CREATE TABLE public.song_collection (
	song_id int4 NOT NULL,
	collection_id int4 NOT NULL,
	id int4 NOT NULL,
	CONSTRAINT song_collection_pk PRIMARY KEY (id),
	CONSTRAINT collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collection(id),
	CONSTRAINT song_id_fkey FOREIGN KEY (song_id) REFERENCES public.song(id)
);