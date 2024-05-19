CREATE DATABASE IF NOT EXISTS `yd_note_workers`;

CREATE DATABASE IF NOT EXISTS `yd_user_db`;

GRANT ALL ON `yd_note_workers`.* TO 'root'@'%';
GRANT ALL ON `yd_note_workers`.* TO 'metrosite'@'%';
GRANT ALL ON `yd_user_db`.* TO 'root'@'%';
GRANT ALL ON `yd_user_db`.* TO 'metrosite'@'%';