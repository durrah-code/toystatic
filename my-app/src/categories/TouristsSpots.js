import React from "react";
import video from "./video3.mp4"

export const TouristSpots = () => {
    return (
        <div style={{textAlign: 'center'}}>
            <h1>Must-Visit Destinations: “Top Spots You Can't Miss in Penang”</h1>
            <p>
                “From breathtaking views to vibrant landscapes, Penang offers a range of unmissable
                destinations that promise unforgettable experiences. </p>
            <p> Whether you’re seeking nature, adventure, or tranquility, Penang has something to captivate every
                traveler. </p>
            <p>Start your journey and uncover the beauty of this incredible island!
            </p>



            <div style={{textAlign: 'center', marginBottom: '30px'}}>
                <h2>Watch: Explore Penang's Tourist Spots</h2>
                <video width="750" height="500" controls>
                    <source src={video} type="video/mp4"/>
                </video>
            </div>


            {/* Dynamic Content Section with Image-Text Pairs */}
            <div id="dynamic-content">
                <div className="image-text-pair" style={{display: 'flex', alignItems: 'center', marginBottom: '30px'}}>
                    <img
                        src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-UevIu0quDBuXF2nQ7eGQsOQpAfc3Y0srtg&s"
                        alt="Penang Hill"
                        style={{
                            width: '120px',
                            height: '120px',
                            borderRadius: '50%',
                            objectFit: 'cover',
                            marginRight: '20px'
                        }}
                    />
                    <div className="text" style={{flex: 1}}>
                        <h3>Penang Hill</h3>
                        <p>Escape the city buzz and ascend into the serene beauty of Penang Hill, a hill resort
                            nestled in the lush highlands of Air Itam. Known as Bukit Bendera in Malay, this
                            iconic destination boasts cool weather, panoramic views, and a rich historical charm.</p>
                        <p>For directions to Penang Hill, visit the <a
                            href="https://www.bing.com/maps?osid=846390ec-0d77-4219-a992-ce6c14fa77d0&cp=5.419768~100.269899&lvl=16&style=h&pi=0&v=2&sV=2&form=S00027"
                            target="_blank" rel="noopener noreferrer">Penang Hill location on Bing Maps</a>.</p>
                    </div>
                </div>

                <div className="image-text-pair" style={{display: 'flex', alignItems: 'center', marginBottom: '30px'}}>
                    <img
                        src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKkNng-eRXpHK8USBsRFUUZtDIePZ8vSelLQ&s"
                        alt="Gurney Bay"
                        style={{
                            width: '120px',
                            height: '120px',
                            borderRadius: '50%',
                            objectFit: 'cover',
                            marginRight: '20px'
                        }}
                    />
                    <div className="text" style={{flex: 1}}>
                        <h3>Gurney bay</h3>
                        <p>Unwind by the sea at Gurney Bay, Penang’s newest and most vibrant waterfront
                            destination. Located along the iconic Gurney Drive, this picturesque spot offers
                            something for everyone, whether you're a nature enthusiast, food lover, or simply
                            seeking a serene escape.
                        </p>
                        <p>For directions to Gurney Bay, visit the <a
                            href="https://www.bing.com/maps?osid=49b33735-e9eb-421d-90a7-2e857e66fae3&cp=57.800002~-154.763653&lvl=16&pi=0&v=2&sV=2&form=S00027"
                            target="_blank" rel="noopener noreferrer">Gurney Bay location on Bing Maps</a>.</p>
                    </div>
                </div>

                <div className="image-text-pair" style={{display: 'flex', alignItems: 'center', marginBottom: '30px'}}>
                    <img
                        src="data:image/jpeg;base64,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"
                        alt="Batu Ferringhi"
                        style={{
                            width: '120px',
                            height: '120px',
                            borderRadius: '50%',
                            objectFit: 'cover',
                            marginRight: '20px'
                        }}
                    />
                    <div className="text" style={{flex: 1}}>
                        <h3>Batu Ferringhi beach</h3>
                        <p>Batu Ferringhi is Penang’s ultimate beach destination, known for its golden sands,
                            sparkling blue waters, and vibrant atmosphere. Whether you're looking for a laid-back
                            retreat or an action-packed adventure, this seaside escape has it all.</p>
                        <p>For directions to Batu Ferringhi, visit the <a
                            href="https://www.bing.com/maps?osid=48ca7891-e355-414a-9f3a8bb347e569a3&cp=5.471737~100.256734&lvl=14.836926&style=h&pi=0&imgid=46bcca5b-feb7-49cb-94ac-51e2fae55ea3&v=2&sV=2&form=S00027"
                            target="_blank" rel="noopener noreferrer">Batu Ferringhi location on Bing Maps</a>.</p>
                    </div>
                </div>

                <div className="image-text-pair" style={{display: 'flex', alignItems: 'center', marginBottom: '30px'}}>
                    <img
                        src="https://photos.smugmug.com/Asia/Malaysia/Georgetown-2020s/i-x9VSs2H/0/DfRLrqW3QdGcBXQjFQXgMSPBpvvgnRtvfqKDqqC3F/L/20240518_160933-gurney-bay-new-trees-L.jpg"
                        alt="Pulau Jerajak Beach"
                        style={{
                            width: '120px',
                            height: '120px',
                            borderRadius: '50%',
                            objectFit: 'cover',
                            marginRight: '20px'
                        }}
                    />
                    <div className="text" style={{flex: 1}}>
                        <h3>Pulau Jerejak Beach</h3>
                        <p>This pretty tropical island off the coast of Penang is home to
                            lush rainforests and pristine beaches. The verdant landscape,
                            tranquil vibes & one of the cleanest beaches in Penang
                            have transformed Pulau Jerejak into an eco-tourism hub.
                        </p>
                        <p>For directions to Pulau Jerejak Beach, visit the <a
                            href="https://www.bing.com/maps?osid=67441cce-1f22-445e-a802-01d4f5df21a2&cp=5.425172~100.266037&lvl=17&pi=0&v=2&sV=2&form=S00027 "
                            target="_blank" rel="noopener noreferrer">Pulau Jerejak Beach location on Bing Maps</a>.</p>
                    </div>
                </div>
            </div>
        </div>
    );
};


