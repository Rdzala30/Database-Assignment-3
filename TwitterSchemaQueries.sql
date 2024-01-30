--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `Password` varchar(16) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) 

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserId`, `name`, `email`, `phone`, `Password`, `CreatedAt`) VALUES
(1, 'Vader', 'vader@gmail.com', '', 'vader#123', '2024-01-25 08:30:45'),
(2, 'Leia', '', '9988776655', 'leia#145', '2024-01-25 15:12:20'),
(3, 'Obi-van', 'obivan123@gmail.com', '8844557799', 'obi#van@123', '2024-01-25 18:45:10');

-- --------------------------------------------------------

--
-- Table structure for table `tweets`
--

CREATE TABLE `tweets` (
  `TweetId` int(11) NOT NULL,
  `UserId` int(11) DEFAULT NULL,
  `content` varchar(280) DEFAULT NULL,
  `is_comment` tinyint(1) DEFAULT 0,
  `OriginalTweetId` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) 

--
-- Dumping data for table `tweets`
--

INSERT INTO `tweets` (`TweetId`, `UserId`, `content`, `is_comment`, `OriginalTweetId`, `timestamp`) VALUES
(11, 1, 'I find your lack of faith disturbing', 0, NULL, '2024-01-26 02:20:55'),
(12, 3, 'The Force will be with you Always', 0, NULL, '2024-01-26 09:35:30'),
(13, 2, 'Help me, Obi-van Kenobi. You are my only hope', 1, 12, '2024-01-26 14:55:42');

--------------------------------------------------------------

--
-- Table structure for table `followers`
--

CREATE TABLE `followers` (
  `FollowerID` int(11) NOT NULL,
  `FollowerUserID` int(11) DEFAULT NULL,
  `FollowingUserID` int(11) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) 

--
-- Dumping data for table `followers`
--

INSERT INTO `followers` (`FollowerID`, `FollowerUserID`, `FollowingUserID`, `CreatedAt`) VALUES
(41, 2, 1, '2024-01-27 05:10:18'),
(42, 1, 3, '2024-01-27 05:45:58');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `LikeID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `TweetID` int(11) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
)

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`LikeID`, `UserID`, `TweetID`, `CreatedAt`) VALUES
(21, 2, 11, '2024-01-27 11:25:37');

-- --------------------------------------------------------

--
-- Table structure for table `retweets`
--

CREATE TABLE `retweets` (
  `RetweetID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `OriginalTweetID` int(11) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) 

--
-- Dumping data for table `retweets`
--

INSERT INTO `retweets` (`RetweetID`, `UserID`, `OriginalTweetID`, `CreatedAt`) VALUES
(31, 3, 11, '2024-01-27 17:40:28');

-- --------------------------------------------------------

--
-- Indexes for dumped tables
--

--
-- Indexes for table `followers`
--
ALTER TABLE `followers`
  ADD PRIMARY KEY (`FollowerID`),
  ADD KEY `FollowerUserID` (`FollowerUserID`),
  ADD KEY `FollowingUserID` (`FollowingUserID`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`LikeID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `TweetID` (`TweetID`);

--
-- Indexes for table `retweets`
--
ALTER TABLE `retweets`
  ADD PRIMARY KEY (`RetweetID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `OriginalTweetID` (`OriginalTweetID`);

--
-- Indexes for table `tweets`
--
ALTER TABLE `tweets`
  ADD PRIMARY KEY (`TweetId`),
  ADD KEY `fk_user` (`UserId`),
  ADD KEY `fk_original_tweet` (`OriginalTweetId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tweets`
--
ALTER TABLE `tweets`
  MODIFY `TweetId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `followers`
--
ALTER TABLE `followers`
  ADD CONSTRAINT `followers_ibfk_1` FOREIGN KEY (`FollowerUserID`) REFERENCES `users` (`UserId`),
  ADD CONSTRAINT `followers_ibfk_2` FOREIGN KEY (`FollowingUserID`) REFERENCES `users` (`UserId`);

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserId`),
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`TweetID`) REFERENCES `tweets` (`TweetId`);

--
-- Constraints for table `retweets`
--
ALTER TABLE `retweets`
  ADD CONSTRAINT `retweets_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserId`),
  ADD CONSTRAINT `retweets_ibfk_2` FOREIGN KEY (`OriginalTweetID`) REFERENCES `tweets` (`TweetId`);

--
-- Constraints for table `tweets`
--
ALTER TABLE `tweets`
  ADD CONSTRAINT `fk_original_tweet` FOREIGN KEY (`OriginalTweetId`) REFERENCES `tweets` (`TweetId`),
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`);
COMMIT;


