# ARchive

A new Flutter project.

## Inspiration

With over 40,000 students at Purdue, it’s easy to feel isolated and unheard, especially for women in tech who may navigate male-dominated industries alone. We created ARchive to provide a platform for students to share inspiring quotes and express themselves openly, transforming empty spaces on campus into an interconnected virtual world. Targeted for women and minorities, this app empowers their voices and contributions that may be overlooked on a daily basis. ARchive reminds everyone that they are not alone and their voice matters.

## What it does

ARchive is an augmented reality environment where you can add custom notes or quotes around the space from your phone. The app stores the content and position of your notes, so it will be in the same location in the virtual environment for everyone else to discover.

Want to interact with the note? By tapping on the note, you can read more details about the note and comment or like the note. If you don't like your notes, you can also select to delete them.

## How we built it

We developed ARchive using Flutter for app development and Apple's ARKit framework to create the augmented reality environment. We used Firebase for OAuth authentication and data storage. Finally, we prototyped our UI design on Figma.

## Challenges we ran into

One of the biggest challenges we ran into was understanding the position and rotation vectors of the AR space since we were new to ARKit. When we tried to attach the nodes of our plane to the plane of the wall, our plane was always constant, no matter the orientation. We tried many strategies like finding the quaternion vector to figure out the rotation; but eventually, we had our objects positioned properly!

## Accomplishments that we're proud of

Building a project that has the ability to empower others
Learning about ARKit
Having fun

## What we learned

This was our team's first time working with the ARKit framework, so it was a fun learning experience to understand 3D spaces, positions, gestures, and other augmented reality tools. Also, for most of the team, this was our first time using Flutter. Although we had many challenges and questions in the beginning, we were able to learn a lot about these tools!
