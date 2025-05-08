import 'package:flutter/material.dart';
import 'package:untitled3/core/constants/constants.dart';

import '../../domain/entities/course.dart';

  final List<Course> Alphabets = [

    Course(
      title: 'Letter A',
      bgcolor:BlueColor1,
      image: 'assets/A.png',
      subtitle: 'The letter "A" is the first letter of the Latin alphabet and is considered a consonant. Its shape features a flat base with two slanted sides meeting at the top to form a triangle. ',
      extraImage: 'assets/A_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter B',
      bgcolor: BlueColor3,
      image: 'assets/B.png',
      subtitle: 'B: A letter with two rounded curves attached to a vertical line. It’s a voiced consonant.',
      extraImage: 'assets/B_Sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter C',
      bgcolor:BlueColor3,
      image: 'assets/C.png',
      subtitle: 'C: A curved letter shaped like an open arc. It represents a soft or hard "k" sound in different words',
      extraImage: 'assets/C_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter D',
      bgcolor: BlueColor1,
      image: 'assets/D.png',
      subtitle: 'D: A letter with a straight vertical line and a rounded curve on the right. It’s a voiced consonant',
      extraImage: 'assets/D_Sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter E',
      bgcolor:BlueColor1,
      image: 'assets/E.png',
      subtitle: 'E: A letter with three horizontal lines, one vertical line on the left. It’s often a vowel, producing different sounds',
      extraImage: 'assets/E_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter F',
      bgcolor:BlueColor3,
      image: 'assets/F.png',
      subtitle: 'F: A letter with a straight vertical line and two horizontal lines on top and middle. It’s a consonant used for the "f" sound',
      extraImage: 'assets/F_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter G',
      bgcolor:BlueColor3,
      image: 'assets/G.png',
      subtitle: 'G: A letter shaped like an "F" with an additional curve at the bottom. It can have a hard or soft pronunciation.',
      extraImage: 'assets/G_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter H',
      bgcolor:BlueColor1,
      image: 'assets/H.png',
      subtitle: 'H: A letter made of two vertical lines connected by a horizontal line in the middle. It represents a voiceless sound',
      extraImage: 'H_Sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter I',
      bgcolor:BlueColor1,
      image: 'assets/I.png',
      subtitle: 'I: A simple straight line, often a vowel, and sometimes used as a pronoun in English.',
      extraImage: 'assets/I_sign-removebg-preview (1).png',
    ),
    Course(
      title: 'Letter J',
      bgcolor:BlueColor3,
      image: 'assets/J.png',
      subtitle: 'J: A letter with a curved bottom and a straight vertical line at the top. It represents a "j" sound',
      extraImage: 'assets/J_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter K',
      bgcolor:BlueColor3,
      image: 'assets/K.png',
      subtitle: 'K: A letter consisting of a vertical line and two angled lines that meet at the middle. It represents a hard "k" sound',
      extraImage: 'assets/K_Sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter L',
      bgcolor:BlueColor1,
      image: 'assets/L.png',
      subtitle: 'L: A letter with a vertical line and a horizontal line at the bottom. It’s often used in many words and represents a liquid consonant.',
      extraImage: 'assets/L_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter M',
      bgcolor:BlueColor1,
      image: 'assets/M.png',
      subtitle: 'M:A letter formed with two vertical lines and a central "V" shape. It’s used in many languages as a consonant.',
      extraImage: 'assets/M_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter N',
      bgcolor:BlueColor3,
      image: 'assets/N.png',
      subtitle: 'N: A letter made of a vertical line with a diagonal line crossing it. It’s a consonant with a nasal sound',
      extraImage: 'assets/N_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter O',
      bgcolor:BlueColor3,
      image: 'assets/O.png',
      subtitle: 'O: A rounded letter, representing the vowel sound "o". It’s symmetrical and simple in appearance.',
      extraImage: 'assets/O_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter P',
      bgcolor:BlueColor1,
      image: 'assets/P.png',
      subtitle: 'P: A letter with a vertical line and a rounded upper part. It represents a "p" sound.',
      extraImage: 'assets/P_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter Q',
      bgcolor:BlueColor3,
      image: 'assets/Q.png',
      subtitle: 'Q: Similar to "O", but with a small diagonal line added to the bottom right. It’s often used with "U" in words',
      extraImage: 'assets/Q_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter R',
      bgcolor:BlueColor1,
      image: 'assets/R-removebg-preview.png',
      subtitle: 'R:A letter with a vertical line and a rounded part at the top, plus a diagonal line at the bottom. It represents a "r" sound',
      extraImage: 'assets/R_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter S',
      bgcolor:BlueColor1,
      image: 'assets/S-removebg-preview.png',
      subtitle: 'S: A letter shaped like a smooth curve, representing a "s" sound.',
      extraImage: 'assets/S_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter T',
      bgcolor:BlueColor3,
      image: 'assets/T-removebg-preview.png',
      subtitle: 'T: A letter with a straight vertical line and a horizontal line at the top. It represents a "t" sound.',
      extraImage: 'assets/T_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter U',
      bgcolor:BlueColor3,
      image: 'assets/U-removebg-preview.png',
      subtitle: 'U: A rounded letter resembling an open "V". It is often a vowel.',
      extraImage: 'assets/U_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter V',
      bgcolor:BlueColor1,
      image: 'assets/V-removebg-preview.png',
      subtitle: 'V: A letter shaped like a triangle, formed by two diagonal lines meeting at the bottom. It represents a "v" sound',
      extraImage: 'assets/V_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter W',
      bgcolor:BlueColor1,
      image: 'assets/W-removebg-preview.png',
      subtitle: 'W: A letter formed by two "V" shapes placed side by side. It represents a "w" sound.',
      extraImage: 'assets/W_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter X',
      bgcolor:BlueColor3,
      image: 'assets/X-removebg-preview.png',
      subtitle: 'X: A letter shaped by two diagonal lines crossing each other. It represents a "ks" sound.',
      extraImage: 'assets/X_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter Y',
      bgcolor:BlueColor3,
      image: 'assets/Y-removebg-preview.png',
      subtitle: 'Y: A letter with a "V" shape at the top and a straight line going down. It is a consonant or a vowel in different contexts',
      extraImage: 'assets/Y_sign-removebg-preview.png',
    ),
    Course(
      title: 'Letter Z',
      bgcolor:BlueColor1,
      image: 'assets/Z.png',
      subtitle: 'Z: A letter formed by two horizontal lines and a diagonal line connecting them. It represents a "z" sound',
      extraImage: 'assets/Z_sign-removebg-preview.png',
    ),
  ];

// قائمة العبارات الشائعة
  final List<Course> CommonPhrases = [
    Course(
      title: 'Hi',
      bgcolor:  BlueColor2,
      image: 'assets/Hi-removebg-preview.png',
      subtitle: '',
      extraImage: 'assets/hi_sign-removebg-preview.png',
    ),
    Course(
      title: 'How are you ?',
      bgcolor: BlueColor1,
      image: 'assets/how_are-removebg-preview.png',
      subtitle: '',
      extraImage: 'assets/how_are_you-removebg-preview.png',
    ),
    Course(
      title: 'My name is ',
      bgcolor: BlueColor1,
      image: 'assets/my_name-removebg-preview.png',
      subtitle: '',
      extraImage: 'assets/ChatGPT_Image_Apr_21__2025__07_58_32_PM-removebg-preview.png',
    ),
    Course(
      title: 'I love you',
      bgcolor: BlueColor2,
      image: 'assets/I_love_you-removebg-preview.png',
      subtitle: '',
      extraImage: 'assets/i_love_you-sign-removebg-preview.png',
    ),

  ];

// قائمة الأرقام
  final List<Course> Numbers = [


    Course(
      title: '1',
      bgcolor: BlueColor2,
      image: 'assets/1-removebg-preview.png',
      subtitle: 'One (1) – The first natural number. It represents a single unit or thing. It’s often seen as a symbol of unity and beginning.',
      extraImage: 'assets/1_sign-removebg-preview.png',
    ),
    Course(
      title: '2',
      bgcolor: BlueColor3,
      image: 'assets/2-removebg-preview.png',
      subtitle: 'Two (2) – The second number. It represents a pair or a couple. It’s the smallest even number',
      extraImage: 'assets/2_sign-removebg-preview.png',
    ),
    Course(
      title: '3',
      bgcolor: BlueColor3,
      image: 'assets/3-removebg-preview.png',
      subtitle: 'Three (3) – The third number. Often associated with balance or harmony (beginning, middle, end).',
      extraImage: 'assets/3_Sign-removebg-preview.png',
    ),
    Course(
      title: '4',
      bgcolor: BlueColor2,
      image: 'assets/4-removebg-preview.png',
      subtitle: 'Four (4) – A number representing stability and structure, like four sides of a square or four seasons.',
      extraImage: 'assets/4_sign-removebg-preview.png',
    ),
    Course(
      title: '5',
      bgcolor: BlueColor2,
      image: 'assets/5-removebg-preview.png',
      subtitle: 'Five (5) – A number often linked to human senses (sight, hearing, touch, taste, smell). It’s also halfway to ten.',
      extraImage: 'assets/5_sign-removebg-preview.png',
    ),
    Course(
      title: '6',
      bgcolor: BlueColor3,
      image: 'assets/6-removebg-preview.png',
      subtitle: 'Six (6) – A number that represents harmony and balance. It’s the first perfect number in mathematics.',
      extraImage: 'assets/6_sign-removebg-preview.png',
    ),
    Course(
      title: '7',
      bgcolor: BlueColor3,
      image: 'assets/7.-removebg-preview.png',
      subtitle: 'Seven (7) – Often considered a lucky or spiritual number. There are seven days in a week, seven continents, etc.',
      extraImage: 'assets/7_sign-removebg-preview.png',
    ),
    Course(
      title: '8',
      bgcolor: BlueColor2,
      image: 'assets/8-removebg-preview.png',
      subtitle: 'Eight (8) – A number symbolizing infinity or completeness, especially because of its shape (∞ rotated).',
      extraImage: 'assets/8_sign-removebg-preview.png',
    ),
    Course(
      title: '9',
      bgcolor: BlueColor2,
      image: 'assets/9-removebg-preview.png',
      subtitle: 'Nine (9) – The last single-digit number. It’s associated with wisdom and experience.',
      extraImage: 'assets/9_sign-removebg-preview.png',
    ),
    Course(
      title: '10',
      bgcolor: BlueColor3,
      image: 'assets/10-removebg-preview.png',
      subtitle: 'Ten (10) – A base number in our decimal system. It represents completeness and a full cycle (like 10 fingers).',
      extraImage: 'assets/10_sign-removebg-preview.png',
    ),
  ];