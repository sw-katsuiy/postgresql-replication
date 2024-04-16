$ docker-compose up
でprimary, replica, logical-replicaという名前の3つのDBサーバーが立ち上がります。
primaryとreplicaは自動的に物理レプリケーションの関係です。
以下の手順で、primaryをpublisher、logical-replicaをsubscriberとする論理レプリケーションが開始できます。

primary側
1. 任意にテーブルを作成(primary_key必須)
2. CREATE PUBLICATION test_pub FOR ALL TABLES; (パブリケーションを作成)
3. SELECT * FROM pg_publication_tables; (パブリケーションの作成を確認)

logical-replica側
1. primary側のテーブルと同様のものを作成(中身は空にしておく)
2. CREATE SUBSCRIPTION test_sub CONNECTION 'host=primary user=root password=password port=5432 dbname=db connect_timeout=10' PUBLICATION test_pub; (論理レプリケーション開始)
3. 勝手に同期されます。
