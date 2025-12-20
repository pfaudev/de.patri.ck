
  CREATE TABLE `clipper_items` (
    `_id` INT (10) NOT NULL AUTO_INCREMENT,
    `set_id` INT (10) NOT NULL,
    `name` VARCHAR (255) NOT NULL,
    `image` VARCHAR (255) NOT NULL,
    `own` ENUM ('0', '1') DEFAULT 0,
    `tags` INT (10),
    `datum` DATE,
    `lastedit` DATETIME NOT NULL,
    PRIMARY KEY (`_id`)
  )
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;

  CREATE TABLE `clipper_user` (
    `_id` INT (10) NOT NULL AUTO_INCREMENT,
    `user_name` VARCHAR (100) NOT NULL,
    `user_pass` VARCHAR (100),
    `user_mail` VARCHAR (100) NOT NULL,
    `user_image` VARCHAR (255) DEFAULT "benutzer.png",
    PRIMARY KEY (`_id`)
  )
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;


CREATE TABLE `clipper_sets`(`_id` INT (10) NOT NULL AUTO_INCREMENT, `name` VARCHAR (255) NOT NULL, `image` VARCHAR (255) NOT NULL, `own` INT (1) DEFAULT 0, `tags` INT (10), `datum` DATE, `lastedit` DATETIME, PRIMARY KEY(`_id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `clipper_tags`(`_id` INT (10) NOT NULL AUTO_INCREMENT, `value` VARCHAR (255) NOT NULL, PRIMARY KEY(`_id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `clipper_sets` ADD FOREIGN KEY clipper_it_clipper_se_fk (`_id`) REFERENCES `clipper_items`(`set_id`);
ALTER TABLE `clipper_tags` ADD FOREIGN KEY clipper_se_clipper_ta_fk (`_id`) REFERENCES `clipper_sets`(`tags`);
ALTER TABLE `clipper_tags` ADD FOREIGN KEY clipper_it_clipper_ta_fk (`_id`) REFERENCES `clipper_items`(`tags`);