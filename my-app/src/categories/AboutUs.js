import React from "react";

export const AboutUs = () => {
    return (
        <div className="about-us-container">
            <h1>About Us</h1>
            <p>
                Welcome to Visit Penang! Our mission is to provide visitors with an
                unforgettable experience as they explore the beauty, culture, and
                attractions of Penang. Whether you're a food lover, history enthusiast,
                or adventure seeker, Penang has something special for everyone.
                Discover the charm of our island through our curated categories and
                make your trip truly memorable.
            </p>

            <div className="about-image">
                <img
                    src="https://images.says.com/uploads/story_source/source_image/505597/fd75.jpg" // Replace with actual image URL
                    alt="Penang"
                    className="about-image-img"
                />
                <div className="about-description">
                    <h3>The Old Name of Penang</h3>
                    <p>
                        Penang was formerly known as Pulau Ka Satu. A sea rover by the name of Ragam named it
                        Pulau Ka Satu a single island as it was the only large the isolated land he came across
                        on his trading trips between Lingga and Kedah. The name was retained until the coming of
                        the British in 1786. When the areca palm was cultivated on the island after the arrival of
                        British, the name of island was later changed in Pulau Pinang.
                        Over time, Penang attracted diverse ethnic groups, including Malays, Chinese, and Indians,
                        contributing to its vibrant culture. Today, Penang is known for its UNESCO-listed George Town,
                        blending colonial charm with modern innovation and a booming tourism industry
                    </p>
                </div>
            </div>
            <div className="news-row">
                <div className="news-container">
                    <h2>NewStaritTimes</h2>
                    <ul className="news-list">
                        <li>
                            <a href="https://www.nst.com.my/news/nation/2025/01/1158680/lrt-project-set-alter-penangs-public-transportation-scene" target="_blank" rel="noopener noreferrer">
                                LRT project set to alter Penang's public transportation scene
                            </a>
                        </li>
                    </ul>
                </div>
                <div className="news-container">
                    <h2>TodaysOnline</h2>
                    <ul className="news-list">
                        <li>
                            <a href="https://www.todayonline.com/8days/heritage-laksa-stall-penang-opens-pop-shop-spore-crispy-tempura-fish-laksa-worth-trying-2160926" target="_blank" rel="noopener noreferrer">
                                Heritage laksa stall from Penang opens pop-up shop in S’pore, crispy tempura fish laksa worth trying
                            </a>
                        </li>
                    </ul>
                </div>
                <div className="news-container">
                    <h2>MalayMail</h2>
                    <ul className="news-list">
                        <li>
                            <a href="https://www.malaymail.com/news/malaysia/2021/09/15/penang-set-to-receive-second-unesco-recognition-with-designation-of-penang/2005784" target="_blank" rel="noopener noreferrer">
                                Penang set to receive second Unesco recognition with designation of Penang Hill as a biosphere reserve
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div className="news-row">
                <div className="news-container">
                    <h2>Bernama</h2>
                    <ul className="news-list">
                        <li>
                            <a href="https://www.bernama.com/en/news.php?id=2371042" target="_blank" rel="noopener noreferrer">
                                Penang Second Bridge Will Be Temporarily Close
                            </a>
                        </li>
                    </ul>
                </div>
                <div className="news-container">
                    <h2>Today Online</h2>
                    <ul className="news-list">
                        <li>
                            <a href="https://www.todayonline.com/world/chiak-pa-boey-penang-seeks-register-hokkien-dialect-state-heritage-2205196" target="_blank" rel="noopener noreferrer">
                                ‘Chiak pa boey?' Penang seeks to register Hokkien dialect as state heritage
                            </a>
                        </li>
                    </ul>
                </div>
                <div className="news-container">
                    <h2>TheStraitsTime</h2>
                    <ul className="news-list">
                        <li>
                            <a href="https://www.straitstimes.com/asia/se-asia/four-iconic-penang-murals-restored-by-lithuanian-artist-ernest-zacharevic-12-years-later" target="_blank" rel="noopener noreferrer">
                                Four iconic Penang murals restored by Lithuanian artist Ernest Zacharevic after 12 years
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>


    );
};



