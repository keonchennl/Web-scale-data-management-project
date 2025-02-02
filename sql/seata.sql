PGDMP         "                z           seata    14.3    14.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16438    seata    DATABASE     P   CREATE DATABASE seata WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
    DROP DATABASE seata;
                postgres    false            �            1259    16448    branch_table    TABLE     �  CREATE TABLE public.branch_table (
    branch_id bigint NOT NULL,
    xid character varying(128) NOT NULL,
    transaction_id bigint,
    resource_group_id character varying(32),
    resource_id character varying(256),
    branch_type character varying(8),
    status smallint,
    client_id character varying(64),
    application_data character varying(2000),
    gmt_create timestamp(6) without time zone,
    gmt_modified timestamp(6) without time zone
);
     DROP TABLE public.branch_table;
       public         heap    postgres    false            �            1259    16439    global_table    TABLE     �  CREATE TABLE public.global_table (
    xid character varying(128) NOT NULL,
    transaction_id bigint,
    status smallint NOT NULL,
    application_id character varying(32),
    transaction_service_group character varying(32),
    transaction_name character varying(128),
    timeout integer,
    begin_time bigint,
    application_data character varying(2000),
    gmt_create timestamp(0) without time zone,
    gmt_modified timestamp(0) without time zone
);
     DROP TABLE public.global_table;
       public         heap    postgres    false            �            1259    16456 
   lock_table    TABLE     u  CREATE TABLE public.lock_table (
    row_key character varying(128) NOT NULL,
    xid character varying(96),
    transaction_id bigint,
    branch_id bigint NOT NULL,
    resource_id character varying(256),
    table_name character varying(32),
    pk character varying(36),
    gmt_create timestamp(0) without time zone,
    gmt_modified timestamp(0) without time zone
);
    DROP TABLE public.lock_table;
       public         heap    postgres    false            �            1259    20009    undo_log    TABLE     e  CREATE TABLE public.undo_log (
    id integer NOT NULL,
    branch_id bigint NOT NULL,
    xid character varying(128) NOT NULL,
    context character varying(128) NOT NULL,
    rollback_info bytea NOT NULL,
    log_status integer NOT NULL,
    log_created timestamp(0) without time zone NOT NULL,
    log_modified timestamp(0) without time zone NOT NULL
);
    DROP TABLE public.undo_log;
       public         heap    postgres    false            �            1259    20008    undo_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.undo_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.undo_log_id_seq;
       public          postgres    false    213                       0    0    undo_log_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.undo_log_id_seq OWNED BY public.undo_log.id;
          public          postgres    false    212            r           2604    20012    undo_log id    DEFAULT     j   ALTER TABLE ONLY public.undo_log ALTER COLUMN id SET DEFAULT nextval('public.undo_log_id_seq'::regclass);
 :   ALTER TABLE public.undo_log ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212    213                      0    16448    branch_table 
   TABLE DATA           �   COPY public.branch_table (branch_id, xid, transaction_id, resource_group_id, resource_id, branch_type, status, client_id, application_data, gmt_create, gmt_modified) FROM stdin;
    public          postgres    false    210   1                 0    16439    global_table 
   TABLE DATA           �   COPY public.global_table (xid, transaction_id, status, application_id, transaction_service_group, transaction_name, timeout, begin_time, application_data, gmt_create, gmt_modified) FROM stdin;
    public          postgres    false    209   N                 0    16456 
   lock_table 
   TABLE DATA           �   COPY public.lock_table (row_key, xid, transaction_id, branch_id, resource_id, table_name, pk, gmt_create, gmt_modified) FROM stdin;
    public          postgres    false    211   k                 0    20009    undo_log 
   TABLE DATA           u   COPY public.undo_log (id, branch_id, xid, context, rollback_info, log_status, log_created, log_modified) FROM stdin;
    public          postgres    false    213   �                  0    0    undo_log_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.undo_log_id_seq', 1, false);
          public          postgres    false    212            y           2606    16454    branch_table pk_branch_table 
   CONSTRAINT     a   ALTER TABLE ONLY public.branch_table
    ADD CONSTRAINT pk_branch_table PRIMARY KEY (branch_id);
 F   ALTER TABLE ONLY public.branch_table DROP CONSTRAINT pk_branch_table;
       public            postgres    false    210            v           2606    16445    global_table pk_global_table 
   CONSTRAINT     [   ALTER TABLE ONLY public.global_table
    ADD CONSTRAINT pk_global_table PRIMARY KEY (xid);
 F   ALTER TABLE ONLY public.global_table DROP CONSTRAINT pk_global_table;
       public            postgres    false    209            |           2606    16462    lock_table pk_lock_table 
   CONSTRAINT     [   ALTER TABLE ONLY public.lock_table
    ADD CONSTRAINT pk_lock_table PRIMARY KEY (row_key);
 B   ALTER TABLE ONLY public.lock_table DROP CONSTRAINT pk_lock_table;
       public            postgres    false    211            ~           2606    20016    undo_log pk_undo_log 
   CONSTRAINT     R   ALTER TABLE ONLY public.undo_log
    ADD CONSTRAINT pk_undo_log PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.undo_log DROP CONSTRAINT pk_undo_log;
       public            postgres    false    213            �           2606    20018    undo_log ux_undo_log 
   CONSTRAINT     Y   ALTER TABLE ONLY public.undo_log
    ADD CONSTRAINT ux_undo_log UNIQUE (xid, branch_id);
 >   ALTER TABLE ONLY public.undo_log DROP CONSTRAINT ux_undo_log;
       public            postgres    false    213    213            z           1259    16463    idx_branch_id    INDEX     I   CREATE INDEX idx_branch_id ON public.lock_table USING btree (branch_id);
 !   DROP INDEX public.idx_branch_id;
       public            postgres    false    211            s           1259    16446    idx_gmt_modified_status    INDEX     `   CREATE INDEX idx_gmt_modified_status ON public.global_table USING btree (gmt_modified, status);
 +   DROP INDEX public.idx_gmt_modified_status;
       public            postgres    false    209    209            t           1259    16447    idx_transaction_id    INDEX     U   CREATE INDEX idx_transaction_id ON public.global_table USING btree (transaction_id);
 &   DROP INDEX public.idx_transaction_id;
       public            postgres    false    209            w           1259    16455    idx_xid    INDEX     ?   CREATE INDEX idx_xid ON public.branch_table USING btree (xid);
    DROP INDEX public.idx_xid;
       public            postgres    false    210                  x������ � �            x������ � �            x������ � �            x������ � �     