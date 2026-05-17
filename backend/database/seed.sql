-- =====================================================
-- SEED DATA FOR DIARY APPLICATION
-- =====================================================

-- Disable foreign key checks temporarily for clean insertion
PRAGMA foreign_keys = OFF;

-- Clean existing data (optional - for testing purposes)
DELETE FROM shares;
DELETE FROM entries;
DELETE FROM users;

-- Reset autoincrement counters
DELETE FROM sqlite_sequence WHERE name IN ('users', 'entries', 'shares');

-- Re-enable foreign key checks
PRAGMA foreign_keys = ON;

-- =====================================================
-- INSERT USERS (10 users with English first names)
-- Password hashes are bcrypt hashes of 'password123'
-- =====================================================

INSERT INTO users (username, password_hash, admin) VALUES 
('James', '$2y$12$BwLvk7Fd3SBqN8aOM3eh9uln2EgwBiLlSKcnDuNalvvZl3U0H5fb2', 0),
('Emma', '$2y$12$.miL3J6sT7XLdRCL71.3MOAPaKCManJ4XD1qaHBP4ETg.SFFRb9bS', 0),
('Oliver', '$2y$12$DX94PSnrdsYb0n50F9SvouvGOcmiGhD2E321YOYEq1ULGXiU140.S', 0),
('Sophia', '$2y$12$j5aj.pZXwGtlWKa9.u8yduK3SqMrd6X99ds7Hx1RKIknk5bERo.hm', 1),
('William', '$2y$12$cSwqIMSdeLnjbQuQoMVaEumeIHBJ1uPLQAmANEnvpnloOlaq8cTee', 0),
('Olivia', '$2y$12$5BOUvD5Dd5LzKpXx8QTuO.Yaix.jkwwvik7x9RlL1DVE8p176NuzW', 0),
('Henry', '$2y$12$UHd1BRw/o.ykaDHQkaryBeSTk1yzC1mHPLr0LDWF6uumguQ2LtUL6', 0),
('Charlotte', '$2y$12$T3VLzoWfHYhfb06.RYPt.uOH0Rawy5iLvD9SjfHklQZPwljVC9FoG', 0),
('Alexander', '$2y$12$/hLIk.7aCHhow/dx.lZVRe.ffiEdAa.hQhXvoNQb9H2FPxWQk69ja', 0),
('Amelia', '$2y$12$sxVp72qUxh/Jijg6y5/j/.LKdnCs55OXWTbP70wiPw448Cd4/U4K.', 0);

-- =====================================================
-- INSERT ENTRIES FOR EACH USER
-- Each user has 10-20 entries (2-6 sentences each)
-- =====================================================

-- James (id=1) - 15 entries
INSERT INTO entries (user_id, content, created_at, updated_at) VALUES 
(1, 'Woke up feeling refreshed for once. The sun was streaming through the curtains. Made myself a proper breakfast with eggs and toast.', datetime('now', '-45 days'), datetime('now', '-45 days')),
(1, 'Rainy day today. Stayed indoors and read an entire novel in one sitting. My eyes are tired but it was worth it.', datetime('now', '-42 days'), datetime('now', '-42 days')),
(1, 'Met an old friend at the coffee shop. We talked for three hours about everything and nothing. I missed this kind of connection.', datetime('now', '-38 days'), datetime('now', '-38 days')),
(1, 'Work was stressful today. Deadlines are piling up and I feel overwhelmed. Took a long walk after work to clear my head.', datetime('now', '-35 days'), datetime('now', '-35 days')),
(1, 'Baked cookies for the first time. They came out a bit burnt but still edible. The kitchen smelled amazing all evening.', datetime('now', '-31 days'), datetime('now', '-31 days')),
(1, 'Went for a run in the park. My legs are sore but my mind feels lighter. I should do this more often.', datetime('now', '-28 days'), datetime('now', '-28 days')),
(1, 'Called my mom today. She sounded happy. We talked about nothing important but it felt good to hear her voice.', datetime('now', '-24 days'), datetime('now', '-24 days')),
(1, 'Lost my favorite pen somewhere. Looked everywhere but couldn''t find it. This is going to bother me all week.', datetime('now', '-21 days'), datetime('now', '-21 days')),
(1, 'Started learning guitar. My fingers hurt and I can barely play a chord. But I played my first simple melody today.', datetime('now', '-17 days'), datetime('now', '-17 days')),
(1, 'Movie night alone with popcorn and blankets. Watched an old classic I''ve seen a dozen times. Still made me cry.', datetime('now', '-14 days'), datetime('now', '-14 days')),
(1, 'The neighbor''s dog barked all night. I barely slept. Coffee is my only friend this morning.', datetime('now', '-10 days'), datetime('now', '-10 days')),
(1, 'Found a twenty dollar bill in an old jacket pocket. Felt like winning the lottery. Bought coffee and a pastry to celebrate.', datetime('now', '-7 days'), datetime('now', '-7 days')),
(1, 'Feeling grateful today. Nothing special happened, but everything felt right. I need to remember this feeling.', datetime('now', '-5 days'), datetime('now', '-5 days')),
(1, 'Had a disagreement with a coworker. I said things I regret. Need to apologize tomorrow.', datetime('now', '-3 days'), datetime('now', '-3 days')),
(1, 'Cleaned the entire apartment top to bottom. Found three missing socks under the couch. It feels like a new home now.', datetime('now', '-1 days'), datetime('now', '-1 days'));

-- Emma (id=2) - 18 entries
INSERT INTO entries (user_id, content, created_at, updated_at) VALUES 
(2, 'The garden is finally blooming. Planted some roses last spring and they''re beautiful now. Spent the whole morning just looking at them.', datetime('now', '-50 days'), datetime('now', '-50 days')),
(2, 'Finished a difficult book today. It took me two months to get through. The ending was worth all the struggle.', datetime('now', '-47 days'), datetime('now', '-47 days')),
(2, 'Tried yoga for the first time. I fell over three times during tree pose. The instructor was very patient with me.', datetime('now', '-44 days'), datetime('now', '-44 days')),
(2, 'My phone broke and I can''t afford a new one yet. It''s strangely liberating not being reachable. I read two books in three days.', datetime('now', '-40 days'), datetime('now', '-40 days')),
(2, 'Cooked dinner for friends. The pasta was undercooked but nobody complained. We laughed until our stomachs hurt.', datetime('now', '-37 days'), datetime('now', '-37 days')),
(2, 'Walked in the rain without an umbrella. It was cold but refreshing. Now I''m drinking hot tea under a blanket.', datetime('now', '-33 days'), datetime('now', '-33 days')),
(2, 'Had a dream about flying last night. Woke up disappointed that I couldn''t actually fly. Spent the day feeling heavy.', datetime('now', '-30 days'), datetime('now', '-30 days')),
(2, 'Someone complimented my smile today. It made me smile even more. Kindness really is contagious.', datetime('now', '-26 days'), datetime('now', '-26 days')),
(2, 'Stayed up too late watching silly videos online. Regretting it now. But some of them were genuinely hilarious.', datetime('now', '-23 days'), datetime('now', '-23 days')),
(2, 'Bought myself flowers for no reason. They''re sitting on my desk making me happy. Self-care looks like this sometimes.', datetime('now', '-19 days'), datetime('now', '-19 days')),
(2, 'Had a headache all afternoon. Couldn''t focus on anything. Went to bed early and slept for ten hours.', datetime('now', '-16 days'), datetime('now', '-16 days')),
(2, 'Wrote a letter to my future self. I wonder if I''ll ever read it. Put it in an envelope and hid it in a drawer.', datetime('now', '-12 days'), datetime('now', '-12 days')),
(2, 'The sunset was incredible tonight. Pinks and oranges and purples all mixed together. I just stood there watching until it was gone.', datetime('now', '-9 days'), datetime('now', '-9 days')),
(2, 'Forgot to buy milk again. This is the third time this month. My coffee will be black again tomorrow.', datetime('now', '-6 days'), datetime('now', '-6 days')),
(2, 'Helped a stranger carry groceries up the stairs. She was so grateful she gave me a cookie. Small acts matter.', datetime('now', '-4 days'), datetime('now', '-4 days')),
(2, 'Feeling lonely today for no particular reason. I have people who care about me. But loneliness doesn''t care about logic.', datetime('now', '-2 days'), datetime('now', '-2 days')),
(2, 'Listened to my favorite album from high school. Remembered who I was back then. I''ve changed so much, but some things stay the same.', datetime('now', '-1 days'), datetime('now', '-1 days')),
(2, 'Made a list of things I want to learn. It''s a long list. I''ll start with the easiest one tomorrow.', datetime('now', '-11 days'), datetime('now', '-11 days'));

-- Oliver (id=3) - 12 entries
INSERT INTO entries (user_id, content, created_at, updated_at) VALUES 
(3, 'Woke up at 5 AM without an alarm. Watched the sunrise from my balcony. The city looked peaceful for once.', datetime('now', '-48 days'), datetime('now', '-48 days')),
(3, 'Spilled coffee on my white shirt right before a meeting. Had to present looking like a mess. Nobody mentioned it, thankfully.', datetime('now', '-45 days'), datetime('now', '-45 days')),
(3, 'Went hiking in the nearby forest. Got lost for an hour. Found my way back and discovered a beautiful waterfall.', datetime('now', '-41 days'), datetime('now', '-41 days')),
(3, 'Deleted social media apps from my phone. It feels weird not checking them constantly. My screen time is already down by half.', datetime('now', '-38 days'), datetime('now', '-38 days')),
(3, 'My plant is dying despite all my efforts. I''ve tried everything. Maybe I''m not meant to be a plant parent.', datetime('now', '-34 days'), datetime('now', '-34 days')),
(3, 'Had dinner with family after months apart. We argued about politics. But we also laughed and hugged goodbye.', datetime('now', '-31 days'), datetime('now', '-31 days')),
(3, 'Caught myself singing in the shower loudly. Hope the neighbors didn''t hear. I''m not a good singer but it makes me happy.', datetime('now', '-27 days'), datetime('now', '-27 days')),
(3, 'Finished a big project at work. The relief is enormous. Celebrated with takeout and a movie.', datetime('now', '-24 days'), datetime('now', '-24 days')),
(3, 'Went to a museum by myself. Spent three hours looking at paintings. Art is better when you don''t have to rush.', datetime('now', '-20 days'), datetime('now', '-20 days')),
(3, 'My best friend is moving away next month. I''m trying not to be sad about it. But I''ll miss our weekly coffee dates terribly.', datetime('now', '-17 days'), datetime('now', '-17 days')),
(3, 'Fixed the leaky faucet myself. Watched three YouTube tutorials first. It only took two hours and some bad words.', datetime('now', '-13 days'), datetime('now', '-13 days')),
(3, 'Took a mental health day from work. Did absolutely nothing productive. It was exactly what I needed.', datetime('now', '-10 days'), datetime('now', '-10 days'));

-- Sophia (id=4) - 20 entries
INSERT INTO entries (user_id, content, created_at, updated_at) VALUES 
(4, 'Started a new journal today. The pages are so clean and white. I''m excited to fill them with words.', datetime('now', '-52 days'), datetime('now', '-52 days')),
(4, 'Woke up with a cold. My throat hurts and I''m sneezing constantly. Made soup and crawled back into bed.', datetime('now', '-49 days'), datetime('now', '-49 days')),
(4, 'Got promoted at work! I''ve been waiting for this for two years. Celebrated with champagne and cake.', datetime('now', '-46 days'), datetime('now', '-46 days')),
(4, 'Volunteered at the animal shelter today. Walked dogs and cuddled cats. I came home exhausted but happy.', datetime('now', '-43 days'), datetime('now', '-43 days')),
(4, 'Someone cut me off in traffic and I got really angry. Yelled in my car by myself. Felt better after letting it out.', datetime('now', '-39 days'), datetime('now', '-39 days')),
(4, 'Watched a documentary about space. Felt incredibly small and insignificant. Also felt grateful to exist at all.', datetime('now', '-36 days'), datetime('now', '-36 days')),
(4, 'My grandmother sent me a handwritten letter. Her handwriting is shaky now. I cried reading it and called her immediately.', datetime('now', '-32 days'), datetime('now', '-32 days')),
(4, 'Tried to paint for the first time. It looks like a child did it. But I had fun, so I''ll keep trying.', datetime('now', '-29 days'), datetime('now', '-29 days')),
(4, 'Lost my wallet somewhere between home and work. Cancelled all my cards. What a pain this is going to be.', datetime('now', '-25 days'), datetime('now', '-25 days')),
(4, 'The first snow of the season fell today. Everything looks magical and quiet. Built a tiny snowman on the balcony.', datetime('now', '-22 days'), datetime('now', '-22 days')),
(4, 'Had a long phone call with an old friend. We haven''t spoken in years. It was like no time had passed at all.', datetime('now', '-18 days'), datetime('now', '-18 days')),
(4, 'Felt really anxious today for no reason. My chest was tight all morning. Deep breathing helped a little.', datetime('now', '-15 days'), datetime('now', '-15 days')),
(4, 'Bought a new plant. Named it Fernando. I''m determined to keep this one alive.', datetime('now', '-11 days'), datetime('now', '-11 days')),
(4, 'Went to a concert alone. It was intimidating at first. But I danced like nobody was watching because nobody was.', datetime('now', '-8 days'), datetime('now', '-8 days')),
(4, 'Made a mistake at work that cost us time. Apologized to my team. They were understanding, but I still feel guilty.', datetime('now', '-5 days'), datetime('now', '-5 days')),
(4, 'Stayed up until 3 AM reading. The book was too good to put down. Now I''m exhausted but no regrets.', datetime('now', '-3 days'), datetime('now', '-3 days')),
(4, 'Cooked a meal from scratch using only pantry ingredients. It turned out surprisingly delicious. I''m getting better at this.', datetime('now', '-2 days'), datetime('now', '-2 days')),
(4, 'Went for a bike ride through the park. The autumn leaves were everywhere. I rode through a pile and they flew up around me.', datetime('now', '-1 days'), datetime('now', '-1 days')),
(4, 'Had a vivid dream about being back in high school. Woke up relieved that those days are over. Adulthood is hard but better.', datetime('now', '-7 days'), datetime('now', '-7 days'));

-- William (id=5) - 14 entries
INSERT INTO entries (user_id, content, created_at, updated_at) VALUES 
(5, 'Woke up with a song stuck in my head. Been humming it all day. I don''t even like the song that much.', datetime('now', '-44 days'), datetime('now', '-44 days')),
(5, 'Went to the dentist for a cleaning. No cavities! The hygienist said my flossing has improved. Small victories.', datetime('now', '-40 days'), datetime('now', '-40 days')),
(5, 'Tried to fix my laptop myself. Made it worse. Now I have to take it to a professional.', datetime('now', '-37 days'), datetime('now', '-37 days')),
(5, 'Watched the stars from my backyard. Saw a shooting star and made a wish. I won''t tell what it was.', datetime('now', '-33 days'), datetime('now', '-33 days')),
(5, 'My coffee maker broke this morning. Had to go to a café before work. Maybe this is a sign to cut back on caffeine.', datetime('now', '-30 days'), datetime('now', '-30 days')),
(5, 'Helped a colleague with a difficult task. He was so grateful. It felt good to share my knowledge.', datetime('now', '-26 days'), datetime('now', '-26 days')),
(5, 'Went swimming at the local pool. Haven''t swum in years. My arms are sore but I felt weightless and free.', datetime('now', '-23 days'), datetime('now', '-23 days')),
(5, 'Burned dinner and had to order pizza. The smoke alarm went off and the cat hid under the bed. At least the pizza was good.', datetime('now', '-19 days'), datetime('now', '-19 days')),
(5, 'Had a really productive day at work. Crossed everything off my to-do list. That almost never happens.', datetime('now', '-16 days'), datetime('now', '-16 days')),
(5, 'Felt sad today for reasons I can''t explain. Sat with the feeling instead of fighting it. It passed after a few hours.', datetime('now', '-12 days'), datetime('now', '-12 days')),
(5, 'Found a great new coffee shop near my apartment. The barista remembered my name on the second visit. I''m becoming a regular.', datetime('now', '-9 days'), datetime('now', '-9 days')),
(5, 'Practiced guitar for an hour. My fingers are developing calluses. I can almost play a full song now.', datetime('now', '-5 days'), datetime('now', '-5 days')),
(5, 'Had a picnic in the park by myself. Read a book and ate sandwiches. It was perfectly peaceful.', datetime('now', '-2 days'), datetime('now', '-2 days')),
(5, 'Today was just an ordinary day. Nothing special happened. And that''s perfectly fine with me.', datetime('now', '-4 days'), datetime('now', '-4 days'));

-- Olivia (id=6) - 16 entries
INSERT INTO entries (user_id, content, created_at, updated_at) VALUES 
(6, 'Slept in until noon. It felt glorious and decadent. I needed this so much.', datetime('now', '-49 days'), datetime('now', '-49 days')),
(6, 'Took a pottery class. The clay was cold and messy. My bowl came out lopsided but I love it anyway.', datetime('now', '-46 days'), datetime('now', '-46 days')),
(6, 'Had a disagreement with my partner. We talked it through and made up. Relationships take so much work.', datetime('now', '-42 days'), datetime('now', '-42 days')),
(6, 'Went thrift shopping and found a vintage jacket. It fits perfectly and cost only five dollars. Best find ever.', datetime('now', '-39 days'), datetime('now', '-39 days')),
(6, 'My computer crashed and I lost an hour of work. Wanted to throw it out the window. Took a break and started over.', datetime('now', '-35 days'), datetime('now', '-35 days')),
(6, 'Watched a sad movie and cried for twenty minutes. It was cathartic. I love a good cry sometimes.', datetime('now', '-32 days'), datetime('now', '-32 days')),
(6, 'Went to a farmers market. Bought fresh bread and strawberries. Ate them sitting on a bench watching people.', datetime('now', '-28 days'), datetime('now', '-28 days')),
(6, 'My friend surprised me with tickets to a show. I had no idea. I love surprises when they''re good ones.', datetime('now', '-25 days'), datetime('now', '-25 days')),
(6, 'Felt really proud of myself today. I handled a difficult situation with grace. Growing up feels good sometimes.', datetime('now', '-21 days'), datetime('now', '-21 days')),
(6, 'Wrote a poem for the first time in years. It''s not good. But writing it made me happy.', datetime('now', '-18 days'), datetime('now', '-18 days')),
(6, 'Went for a drive with no destination. Ended up at the beach. Watched the waves for an hour.', datetime('now', '-14 days'), datetime('now', '-14 days')),
(6, 'My neighbor brought me cookies as a thank you for watering her plants. People can be so kind. I should bake something for her too.', datetime('now', '-11 days'), datetime('now', '-11 days')),
(6, 'Stretched for fifteen minutes before bed. My back already feels better. Small habits matter.', datetime('now', '-7 days'), datetime('now', '-7 days')),
(6, 'Had a frustrating day at work. Everything seemed to go wrong. Came home and just sat in silence for a while.', datetime('now', '-4 days'), datetime('now', '-4 days')),
(6, 'Made a new friend at the gym. We''re going to work out together from now on. It''s nice to have a buddy.', datetime('now', '-2 days'), datetime('now', '-2 days')),
(6, 'Today I decided to forgive someone who hurt me. Not for them. For myself. It feels like letting go of a heavy weight.', datetime('now', '-1 days'), datetime('now', '-1 days'));

-- Henry (id=7) - 11 entries
INSERT INTO entries (user_id, content, created_at, updated_at) VALUES 
(7, 'Woke up at 3 AM and couldn''t fall back asleep. Watched infomercials until dawn. Bought something I definitely don''t need.', datetime('now', '-47 days'), datetime('now', '-47 days')),
(7, 'Went to the library and borrowed six books. I''ll probably only read two. But having options feels good.', datetime('now', '-43 days'), datetime('now', '-43 days')),
(7, 'Tried cooking a new recipe. It was a disaster. The kitchen looks like a battlefield. Ordering takeout instead.', datetime('now', '-40 days'), datetime('now', '-40 days')),
(7, 'Had a really good hair day. No idea why. I did nothing different. I''ll take it.', datetime('now', '-36 days'), datetime('now', '-36 days')),
(7, 'Went to a live comedy show. Laughed until my stomach hurt. Comedy is medicine sometimes.', datetime('now', '-33 days'), datetime('now', '-33 days')),
(7, 'My package got delivered to the wrong address. Tracked it down two streets away. The nice lady had kept it safe for me.', datetime('now', '-29 days'), datetime('now', '-29 days')),
(7, 'Felt overwhelmed by all the news today. Turned off my phone and went for a walk. The world will still be there tomorrow.', datetime('now', '-26 days'), datetime('now', '-26 days')),
(7, 'Wrote a list of goals for the next month. Some are big, some are small. I''ll start with making my bed every morning.', datetime('now', '-22 days'), datetime('now', '-22 days')),
(7, 'Had a video call with my siblings. We don''t talk enough. Made a plan to call more often.', datetime('now', '-18 days'), datetime('now', '-18 days')),
(7, 'Spilled red wine on my carpet. Tried every cleaning trick I know. The stain is still there. Now it''s a memory stain.', datetime('now', '-15 days'), datetime('now', '-15 days')),
(7, 'Today was a good day. Simple and quiet and calm. I wish more days were like this.', datetime('now', '-11 days'), datetime('now', '-11 days'));

-- Charlotte (id=8) - 19 entries
INSERT INTO entries (user_id, content, created_at, updated_at) VALUES 
(8, 'Woke up with so much energy. Cleaned the whole house before 9 AM. Now I don''t know what to do with the rest of the day.', datetime('now', '-51 days'), datetime('now', '-51 days')),
(8, 'Tried to meditate for ten minutes. My mind wandered the whole time. Maybe tomorrow will be easier.', datetime('now', '-48 days'), datetime('now', '-48 days')),
(8, 'Went to a friend''s wedding. Cried during the vows. The reception was fun and I danced more than I have in years.', datetime('now', '-45 days'), datetime('now', '-45 days')),
(8, 'Had a flat tire on the way to work. Changed it myself for the first time. Felt very capable and strong.', datetime('now', '-41 days'), datetime('now', '-41 days')),
(8, 'Felt really creative today. Started three different art projects. Finished none of them. But starting is something.', datetime('now', '-38 days'), datetime('now', '-38 days')),
(8, 'My cat is sick and I''m worried. Took her to the vet. She needs medicine and rest. I''ll stay home with her tomorrow.', datetime('now', '-34 days'), datetime('now', '-34 days')),
(8, 'Went on a date with someone new. We had coffee and talked for two hours. I think there might be something here.', datetime('now', '-31 days'), datetime('now', '-31 days')),
(8, 'Forgot my best friend''s birthday. Felt terrible. Sent a gift with expedited shipping and apologized profusely.', datetime('now', '-27 days'), datetime('now', '-27 days')),
(8, 'Watched the sunrise this morning. The colors were unbelievable. Started my day feeling peaceful.', datetime('now', '-24 days'), datetime('now', '-24 days')),
(8, 'Bought myself a nice bottle of wine to celebrate nothing in particular. Drank half of it while listening to jazz. Fancy.', datetime('now', '-20 days'), datetime('now', '-20 days')),
(8, 'Had a nightmare that woke me up at 2 AM. Couldn''t go back to sleep. Read a boring book until I got tired again.', datetime('now', '-17 days'), datetime('now', '-17 days')),
(8, 'Went to a flea market and found an old camera. It still works! Took photos all afternoon like a tourist in my own city.', datetime('now', '-13 days'), datetime('now', '-13 days')),
(8, 'Felt really grateful for my friends today. They showed up for me when I needed help. I hope I do the same for them.', datetime('now', '-10 days'), datetime('now', '-10 days')),
(8, 'Tried to cut my own bangs. It went... okay. Not great but not terrible. They''ll grow back eventually.', datetime('now', '-6 days'), datetime('now', '-6 days')),
(8, 'Went for a long drive with the windows down. Sang loudly to terrible music. It was perfect.', datetime('now', '-4 days'), datetime('now', '-4 days')),
(8, 'My boss praised my work in front of the whole team. I blushed and didn''t know what to say. It felt really nice.', datetime('now', '-2 days'), datetime('now', '-2 days')),
(8, 'Organized my closet and donated three bags of clothes. My space feels lighter now. So does my mind.', datetime('now', '-1 days'), datetime('now', '-1 days'));

-- Alexander (id=9) - 13 entries
INSERT INTO entries (user_id, content, created_at, updated_at) VALUES 
(9, 'Woke up to my alarm and immediately hit snooze. Did this four times. Finally got up feeling groggy.', datetime('now', '-46 days'), datetime('now', '-46 days')),
(9, 'Went to a new restaurant with friends. The food was amazing. We stayed until the staff started cleaning around us.', datetime('now', '-42 days'), datetime('now', '-42 days')),
(9, 'Had a really deep conversation with a stranger on the bus. We talked about life and meaning. I''ll never see him again.', datetime('now', '-39 days'), datetime('now', '-39 days')),
(9, 'My phone storage is full again. Spent an hour deleting photos. Found so many forgotten memories in the process.', datetime('now', '-35 days'), datetime('now', '-35 days')),
(9, 'Went to the gym even though I didn''t want to. Felt great afterwards. Motivation comes after action, not before.', datetime('now', '-32 days'), datetime('now', '-32 days')),
(9, 'Baked bread from scratch. It came out dense but edible. The smell alone was worth the effort.', datetime('now', '-28 days'), datetime('now', '-28 days')),
(9, 'Had a lazy Sunday in bed. Watched movies and ate snacks. Did nothing productive and loved every minute.', datetime('now', '-25 days'), datetime('now', '-25 days')),
(9, 'Felt jealous of a friend''s success today. I''m happy for them but also insecure. These feelings are complicated.', datetime('now', '-21 days'), datetime('now', '-21 days')),
(9, 'Went to a poetry reading. Some of it was pretentious. Some of it was beautiful. I might try writing again.', datetime('now', '-18 days'), datetime('now', '-18 days')),
(9, 'My car made a weird noise on the highway. Pulled over and waited for help. Everything is fine now but I was scared.', datetime('now', '-14 days'), datetime('now', '-14 days')),
(9, 'Started learning a new language online. I can say hello and thank you. It''s a beginning.', datetime('now', '-10 days'), datetime('now', '-10 days')),
(9, 'Had a picnic with friends at sunset. We ate, laughed, and watched the stars come out. These are the moments I live for.', datetime('now', '-7 days'), datetime('now', '-7 days')),
(9, 'Today I told someone how I really feel. It was scary but honest. Whatever happens, I''m glad I said it.', datetime('now', '-3 days'), datetime('now', '-3 days'));

-- Amelia (id=10) - 17 entries
INSERT INTO entries (user_id, content, created_at, updated_at) VALUES 
(10, 'Woke up to birds singing outside my window. It felt like a sign of a good day. Stayed in bed just listening for a while.', datetime('now', '-53 days'), datetime('now', '-53 days')),
(10, 'Tried to dye my hair at home. The color came out different than expected. I actually like it better this way.', datetime('now', '-50 days'), datetime('now', '-50 days')),
(10, 'Had a fight with my sibling over something stupid. We made up an hour later. Family is complicated but worth it.', datetime('now', '-47 days'), datetime('now', '-47 days')),
(10, 'Went for a walk in the cemetery. It sounds morbid but it''s so peaceful there. Read the old headstones and wondered about their lives.', datetime('now', '-43 days'), datetime('now', '-43 days')),
(10, 'My favorite mug broke. I''ve had it for ten years. Glued it back together. Now it has character.', datetime('now', '-40 days'), datetime('now', '-40 days')),
(10, 'Watched a beautiful sunset from my roof. The whole sky turned pink and gold. Felt lucky to be alive.', datetime('now', '-36 days'), datetime('now', '-36 days')),
(10, 'Got a raise at work! I asked for it and they said yes. Proud of myself for asking.', datetime('now', '-33 days'), datetime('now', '-33 days')),
(10, 'Felt really anxious about the future. Made a list of things I can control and things I can''t. Letting go of the second list is hard.', datetime('now', '-29 days'), datetime('now', '-29 days')),
(10, 'Went to a friend''s art show. She''s so talented. Bought a small painting to support her.', datetime('now', '-26 days'), datetime('now', '-26 days')),
(10, 'Slept terribly and woke up grumpy. Everything annoyed me today. Going to bed early to reset.', datetime('now', '-22 days'), datetime('now', '-22 days')),
(10, 'Made a new playlist for running. It''s mostly upbeat pop songs. Ran faster than usual just to keep up with the beat.', datetime('now', '-19 days'), datetime('now', '-19 days')),
(10, 'Had a long talk with my dad on the phone. He gave me advice I didn''t ask for. But he also said he''s proud of me.', datetime('now', '-15 days'), datetime('now', '-15 days')),
(10, 'Went to a silent disco. It was ridiculous and fun. Dancing with headphones on is a weird experience.', datetime('now', '-12 days'), datetime('now', '-12 days')),
(10, 'Spent the day doing absolutely nothing. No guilt, no shame. Rest is productive too.', datetime('now', '-8 days'), datetime('now', '-8 days')),
(10, 'Lost my keys somewhere in the apartment. Looked for an hour. Found them in the freezer. I don''t know how.', datetime('now', '-5 days'), datetime('now', '-5 days')),
(10, 'Felt really happy today for no particular reason. Just a warm feeling inside. I wish I could bottle this.', datetime('now', '-2 days'), datetime('now', '-2 days')),
(10, 'Today I did something that scared me. It wasn''t as bad as I imagined. Fear is often worse than reality.', datetime('now', '-1 days'), datetime('now', '-1 days'));

-- =====================================================
-- INSERT SHARES (using reliable subqueries with LIMIT and OFFSET)
-- =====================================================

-- Shares from James (id=1)
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 1, 2 FROM entries WHERE user_id = 1 LIMIT 1 OFFSET 2;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 1, 4 FROM entries WHERE user_id = 1 LIMIT 1 OFFSET 4;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 1, 3 FROM entries WHERE user_id = 1 LIMIT 1 OFFSET 6;

-- Shares from Emma (id=2)
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 2, 1 FROM entries WHERE user_id = 2 LIMIT 1 OFFSET 0;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 2, 6 FROM entries WHERE user_id = 2 LIMIT 1 OFFSET 9;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 2, 5 FROM entries WHERE user_id = 2 LIMIT 1 OFFSET 14;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 2, 8 FROM entries WHERE user_id = 2 LIMIT 1 OFFSET 15;

-- Shares from Oliver (id=3)
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 3, 7 FROM entries WHERE user_id = 3 LIMIT 1 OFFSET 0;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 3, 9 FROM entries WHERE user_id = 3 LIMIT 1 OFFSET 2;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 3, 2 FROM entries WHERE user_id = 3 LIMIT 1 OFFSET 9;

-- Shares from Sophia (id=4)
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 4, 1 FROM entries WHERE user_id = 4 LIMIT 1 OFFSET 2;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 4, 3 FROM entries WHERE user_id = 4 LIMIT 1 OFFSET 5;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 4, 10 FROM entries WHERE user_id = 4 LIMIT 1 OFFSET 10;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 4, 6 FROM entries WHERE user_id = 4 LIMIT 1 OFFSET 14;

-- Shares from William (id=5)
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 5, 4 FROM entries WHERE user_id = 5 LIMIT 1 OFFSET 1;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 5, 2 FROM entries WHERE user_id = 5 LIMIT 1 OFFSET 3;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 5, 7 FROM entries WHERE user_id = 5 LIMIT 1 OFFSET 7;

-- Shares from Olivia (id=6)
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 6, 1 FROM entries WHERE user_id = 6 LIMIT 1 OFFSET 3;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 6, 9 FROM entries WHERE user_id = 6 LIMIT 1 OFFSET 7;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 6, 5 FROM entries WHERE user_id = 6 LIMIT 1 OFFSET 14;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 6, 8 FROM entries WHERE user_id = 6 LIMIT 1 OFFSET 15;

-- Shares from Henry (id=7)
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 7, 3 FROM entries WHERE user_id = 7 LIMIT 1 OFFSET 2;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 7, 10 FROM entries WHERE user_id = 7 LIMIT 1 OFFSET 4;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 7, 2 FROM entries WHERE user_id = 7 LIMIT 1 OFFSET 9;

-- Shares from Charlotte (id=8)
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 8, 4 FROM entries WHERE user_id = 8 LIMIT 1 OFFSET 1;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 8, 6 FROM entries WHERE user_id = 8 LIMIT 1 OFFSET 5;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 8, 1 FROM entries WHERE user_id = 8 LIMIT 1 OFFSET 8;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 8, 7 FROM entries WHERE user_id = 8 LIMIT 1 OFFSET 13;

-- Shares from Alexander (id=9)
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 9, 5 FROM entries WHERE user_id = 9 LIMIT 1 OFFSET 0;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 9, 3 FROM entries WHERE user_id = 9 LIMIT 1 OFFSET 2;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 9, 8 FROM entries WHERE user_id = 9 LIMIT 1 OFFSET 11;

-- Shares from Amelia (id=10)
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 10, 2 FROM entries WHERE user_id = 10 LIMIT 1 OFFSET 2;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 10, 4 FROM entries WHERE user_id = 10 LIMIT 1 OFFSET 9;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 10, 9 FROM entries WHERE user_id = 10 LIMIT 1 OFFSET 14;
INSERT INTO shares (entry_id, shared_by, shared_with)
SELECT id, 10, 7 FROM entries WHERE user_id = 10 LIMIT 1 OFFSET 16;

-- =====================================================
-- VERIFICATION QUERIES (commented out, for testing)
-- =====================================================
-- SELECT COUNT(*) as total_users FROM users;
-- SELECT COUNT(*) as total_entries FROM entries;
-- SELECT COUNT(*) as total_shares FROM shares;
-- SELECT u.username, COUNT(e.id) as entry_count FROM users u LEFT JOIN entries e ON u.id = e.user_id GROUP BY u.id;
