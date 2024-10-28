# Clinical PPE Detection

This project was developed for the **Voxel51 Hackathon** to detect Clinical Personal Protective Equipment (PPE), including Coveralls, Gloves, Goggles, Masks, and Face Shields. The model is trained on the **CPPE-5 dataset**, a high-quality dataset designed for object detection in medical PPE.

## Table of Contents
- [Dataset](#dataset)
- [Features](#features)
- [Model](#model)
- [Setup](#setup)
- [Training](#training)


## Dataset

**[CPPE-5 (Medical Personal Protective Equipment)](https://paperswithcode.com/sota/object-detection-on-cppe-5)** is a new dataset created to enable the study of specific categorization of medical PPE. CPPE-5 consists of 1,029 high-quality, real-life images, allowing for easy deployment to real-world environments. Each image is annotated with ~4.6 bounding boxes on average.

- **Total Images**: 1,029 (1,000 for training, 29 for testing)
- **Classes**: Coverall, Face Shield, Gloves, Goggles, Mask
- **Bounding Box Annotations**: Provided in COCO format, with mean Average Precision (mAP) as the primary evaluation metric.

### Data Source
(https://huggingface.co/datasets/rishitdagli/cppe-5)
 Data s loaded from Hugging face Dataset. CPPE-5 aims to improve safety and compliance in medical environments by providing an effective solution for identifying PPE usage.

## Features

- **High-Quality Images**: Non-iconic, real-life images that facilitate real-world applications.
- **Annotation Details**: Each object includes bounding boxes, labels, areas, and unique IDs.
- **Classes**:
  - **Coveralls**: Full-body medical gowns for infection control.
  - **Mask**: Respiratory protection for airborne pathogens.
  - **Face Shield**: Full or partial face protection.
  - **Gloves**: Used to prevent cross-contamination.
  - **Goggles**: Eye protection against particulates and chemicals.

## Model

We utilized the **YOLOv8** and **YOLOv11** models, renowned for real-time object detection performance. Both models were optimized with the CPPE-5 dataset to detect PPE accurately in clinical settings.

### Tools Used
- **YOLOv8 and YOLOv11**: State-of-the-art models for object detection.
  


