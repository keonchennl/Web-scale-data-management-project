PGDMP         6                z           Order    14.3    14.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                        0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16398    Order    DATABASE     R   CREATE DATABASE "Order" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
    DROP DATABASE "Order";
                postgres    false                       0    0    DATABASE "Order"    COMMENT     1   COMMENT ON DATABASE "Order" IS 'Order database';
                   postgres    false    3586            �            1259    16402 	   orderinfo    TABLE     `   CREATE TABLE public.orderinfo (
    orderid text NOT NULL,
    userid text,
    paid boolean
);
    DROP TABLE public.orderinfo;
       public         heap    postgres    false                       0    0    TABLE orderinfo    COMMENT     M   COMMENT ON TABLE public.orderinfo IS 'including orderid,userid,paid status';
          public          postgres    false    209            �            1259    16410 	   orderitem    TABLE     �   CREATE TABLE public.orderitem (
    id integer NOT NULL,
    itemid text,
    orderid text,
    price real,
    amount integer DEFAULT 1 NOT NULL
);
    DROP TABLE public.orderitem;
       public         heap    postgres    false                       0    0    TABLE orderitem    COMMENT     E   COMMENT ON TABLE public.orderitem IS 'including orderid,items,cost';
          public          postgres    false    211            �            1259    16409    orderitem_id_seq    SEQUENCE     �   ALTER TABLE public.orderitem ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orderitem_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 99999
    CACHE 1
);
            public          postgres    false    211            �          0    16402 	   orderinfo 
   TABLE DATA           :   COPY public.orderinfo (orderid, userid, paid) FROM stdin;
    public          postgres    false    209   �       �          0    16410 	   orderitem 
   TABLE DATA           G   COPY public.orderitem (id, itemid, orderid, price, amount) FROM stdin;
    public          postgres    false    211                     0    0    orderitem_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.orderitem_id_seq', 0, true);
          public          postgres    false    210            l           2606    16408    orderinfo order_info_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.orderinfo
    ADD CONSTRAINT order_info_pkey PRIMARY KEY (orderid);
 C   ALTER TABLE ONLY public.orderinfo DROP CONSTRAINT order_info_pkey;
       public            postgres    false    209            n           2606    16416    orderitem orderitem_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orderitem
    ADD CONSTRAINT orderitem_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.orderitem DROP CONSTRAINT orderitem_pkey;
       public            postgres    false    211            �      x�3000��I�K�,����� #��      �       x�3�,H�K���4000���4����� K�     