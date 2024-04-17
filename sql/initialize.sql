CREATE TABLE public.users
(
    id bigserial NOT NULL,
    name character varying(10) NOT NULL,
    PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.posts
(
    id bigserial NOT NULL,
    content character varying(140),
    user_id bigint NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.likes
(
    id bigserial NOT NULL,
    user_id bigint NOT NULL,
    post_id bigint NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    FOREIGN KEY (post_id)
        REFERENCES public.posts (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
);

CREATE INDEX user_name_index
    ON public.users USING btree
    (name varchar_ops ASC NULLS LAST)
;
insert into public.users (name) values ('user1'),('user2'),('user3'),('user4'),('user5'),('user6');
insert into public.posts (content, user_id) values ('Hello1',1),('Hello2',2),('Hello3',3),('GoodBye',6);
insert into public.likes (user_id, post_id) values (1,1),(1,2),(1,3),(1,4),(2,2);
